<?php

class User extends DbObject {
    // name of database table
    const DB_TABLE = 'user';

    // database fields
    protected $id;
    protected $first_name;
    protected $last_name;
    protected $email;
    protected $username;
    protected $pw;
    protected $is_admin;
    protected $is_elite;

    // constructor
    public function __construct($args = array()) {
        $defaultArgs = array(
            'id' => null,
            'first_name' => null,
            'last_name' => null,
            'email' => null,
            'username' => '',
            'pw' => '',
            'is_admin' => null,
            'is_elite' => null
            );

        $args += $defaultArgs;

        $this->id = $args['id'];
        $this->first_name = $args['first_name'];
        $this->last_name = $args['last_name'];
        $this->email = $args['email'];
        $this->username = $args['username'];
        $this->pw = $args['pw'];
        $this->is_admin = $args['is_admin'];
        $this->is_elite = $args['is_elite'];
    }

    // save changes to object
    public function save() {
        $db = Db::instance();
        // omit id and any timestamps
        $db_properties = array(
            'username' => $this->username,
            'pw' => $this->pw,
            'email' => $this->email,
            'first_name' => $this->first_name,
            'last_name' => $this->last_name,
            'is_elite' => $this->is_elite,
            'is_admin' => $this->is_admin
            );
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }

    // load object by ID
    public static function loadById($id) {
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

	// load user by username
    public static function loadByUsername($username=null) {
        if($username === null)
            return null;

        $query = sprintf(" SELECT id FROM %s WHERE username = '%s' ",
            self::DB_TABLE,
            $username
            );
        $db = Db::instance();
        $result = $db->lookup($query);
        
        if(!mysql_num_rows($result))
            return null;
        else {
            $row = mysql_fetch_assoc($result);
            $obj = self::loadById($row['id']);
            return ($obj);
        }
    }

    // given a user ID, return that user's username
    public static function getUsernameById($userID=null) {
      if($userID == null)
        return null;

      $query = sprintf("SELECT username FROM %s WHERE id = %d ",
          self::DB_TABLE,
          $userID
        );
      $db = Db::instance();
      $result = $db->lookup($query);
      if(!mysql_num_rows($result))
          return null;
      else {
          $row = mysql_fetch_assoc($result);
          $username = $row['username'];
          return ($username);
      }
    }

     // get all usernames
    public static function getAllUsernames() {

        $query = sprintf(" SELECT * FROM %s ",
            self::DB_TABLE
        );

        $db = Db::instance();
        $result = $db->lookup($query);

        if(!mysql_num_rows($result))
            return null;
        else {
            $objects = array();
            while($row = mysql_fetch_assoc($result)) {
                $objects[] = self::loadById($row['id']);
            }
            return ($objects);
        }
    }
}