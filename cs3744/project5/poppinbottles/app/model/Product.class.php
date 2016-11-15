<?php

class Product extends DbObject {
    // name of database table
    const DB_TABLE = 'product';

    // database fields
    protected $id;
    protected $WineTitle;
    protected $ShortDesc;
    protected $LongDesc;
    protected $Price;
    protected $Volumes;
    protected $Img_Url;
    protected $Creator_Id;
    protected $Rating;

    // constructor
    public function __construct($args = array()) {
        $defaultArgs = array(
            'id' => null,
            'WineTitle' => '',
            'ShortDesc' => null,
            'LongDesc' => null,
            'Price' => 0,
            'Volumes' => '',
            'Img_Url' => null,
            'Creator_Id' => 0,
            'Date_Created' => null,
            'Rating' => null
            );

        $args += $defaultArgs;

        $this->id = $args['id'];
        $this->WineTitle = $args['WineTitle'];
        $this->ShortDesc = $args['ShortDesc'];
        $this->LongDesc = $args['LongDesc'];
        $this->Price = $args['Price'];
        $this->Volumes = $args['Volumes'];
        $this->Img_Url = $args['Img_Url'];
        $this->Creator_Id = $args['Creator_Id'];
        $this->Date_Created = $args['Date_Created'];
        $this->Rating = $args['Rating'];
    }

    // save changes to object
    public function save() {
        $db = Db::instance();
        // omit id and any timestamps
        $db_properties = array(
            'WineTitle' => $this->WineTitle,
            'ShortDesc' => $this->ShortDesc,
            'LongDesc' => $this->LongDesc,
            'Price' => $this->Price,
            'Volumes' => $this->Volumes,
            'Img_Url' => $this->Img_Url,
            'Creator_Id' => $this->Creator_Id,
            'Date_Created' => $this->Date_Created,
            'Rating' => $this->Rating
            );
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }

    // load object by ID
    public static function loadById($id) {
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

    public static function deleteById($id){
        $db = Db::instance();
        $db->delete($id, self::DB_TABLE);
    }

    public static function getByCreator($creatorID) {
        if ($creatorID == null) {
        return null;
      }

      $query = sprintf("SELECT * FROM `%s` WHERE creator_id = %d ",
        self::DB_TABLE,
        $creatorID
      );

      $db = Db::instance();
      $result = $db->lookup($query);

      if (!mysql_num_rows($result)) {
        return null;
      }
      else {
        $listings = array();
        while($row = mysql_fetch_assoc($result)) {
          $listings[] = $row['WineTitle'];
        }

        return ($listings);
      }
    }

    // load all products
    public static function getAllProducts($ordering=null, $limit=null) {
        if($limit){
           $query = sprintf(" SELECT * FROM %s ORDER BY %s DESC LIMIT %s ",
            self::DB_TABLE,
            $ordering,
            $limit
            );
       }
       else{
        $query = sprintf(" SELECT * FROM %s ORDER BY %s DESC ",
            self::DB_TABLE,
            $ordering
            );
        }   
        // $query = sprintf(" SELECT * FROM %s ORDER BY Date_Created DESC ",
        //     self::DB_TABLE
        //     // $limit
        //     );
        $db = Db::instance();
        $result = $db->lookup($query);
        return ($result);
        // if(!mysql_num_rows($result))
        //     return null;
        // else {
        //     $objects = array();
        //     while($row = mysql_fetch_assoc($result)) {
        //         $objects[] = self::loadById($row['id']);
        //     }
        //     return ($objects);
        // }
    }

}
