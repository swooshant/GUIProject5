<?php

class NewsLetter extends DbObject {
    // name of database table
    const DB_TABLE = 'newsletter_signup';

    // database fields
    protected $Name;
    protected $Email;

    // constructor
    public function __construct($args = array()) {
        $defaultArgs = array(
            'id' => null,
            'Name' => '',
            'Email' => '',
            );

        $args += $defaultArgs;

        $this->id = $args['id'];
        $this->Name = $args['Name'];
        $this->Email = $args['Email'];
    }

    // save changes to object
    public function save() {
        $db = Db::instance();
        // omit id and any timestamps
        $db_properties = array(
            'Name' => $this->Name,
            'Email' => $this->Email,
            );
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }

    // load object by ID
    public static function loadById($id) {
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

}