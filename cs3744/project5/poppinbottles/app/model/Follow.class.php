<?php

class Follow extends DbObject {
    // name of database table
    const DB_TABLE = 'follow';

    // database fields
    protected $id;
    protected $follower_id;
    protected $followee_id;
    protected $date_created;

    // constructor
    public function __construct($args = array()) {
        $defaultArgs = array(
            'id' => null,
            'follower_id' => 0,
            'followee_id' => 0,
            'date_created' => null
            );

        $args += $defaultArgs;

        $this->id = $args['id'];
        $this->follower_id = $args['follower_id'];
        $this->followee_id = $args['followee_id'];
        $this->date_created = $args['date_created'];
    }

    // save changes to object
    public function save() {
        $db = Db::instance();
        // omit id and any timestamps
        $db_properties = array(
            'follower_id' => $this->follower_id,
            'followee_id' => $this->followee_id
            );
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }

    // load object by ID
    public static function loadById($id) {
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

    // load a Follow object by usernames
    public static function loadByUsernames($followerUsername=null, $followeeUsername=null) {
      if($followerUsername == null || $followeeUsername == null) {
        return null;
      }

      $followerID = User::loadByUsername($followerUsername)->get('id');
      $followeeID = User::loadByUsername($followeeUsername)->get('id');
      $query = sprintf("SELECT * FROM `%s` WHERE follower_id = %d AND followee_id = %d ",
        self::DB_TABLE,
        $followerID,
        $followeeID
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

}
