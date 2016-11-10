<?php

class Review extends DbObject {
    // name of database table
    const DB_TABLE = 'review';

    // database fields
    protected $id;
    protected $reviewer_id;
    protected $product_id;
    protected $rating;
    protected $review;
    protected $date_created;

    // constructor
    public function __construct($args = array()) {
        $defaultArgs = array(
            'id' => null,
            'reviewer_id' => 0,
            'product_id' => 0,
            'rating' => 0,
            'review' => '',
            'date_created' => null
            );

        $args += $defaultArgs;

        $this->id = $args['id'];
        $this->reviewer_id = $args['reviewer_id'];
        $this->product_id = $args['product_id'];
        $this->rating = $args['rating'];
        $this->review = $args['review'];
        $this->date_created = $args['date_created'];
    }

    // save changes to object
    public function save() {
        $db = Db::instance();
        // omit id and any timestamps
        $db_properties = array(
            'reviewer_id' => $this->reviewer_id,
            'product_id' => $this->product_id,
            'rating' => $this->rating,
            'review' => $this->review
            );
        $db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    }

    // load object by ID
    public static function loadById($id) {
        $db = Db::instance();
        $obj = $db->fetchById($id, __CLASS__, self::DB_TABLE);
        return $obj;
    }

    // load all products
    public static function getReviewsByProductId($productID=null, $limit=null) {
        if($productID==null) {
          return null;
        }

        $query = sprintf(" SELECT id FROM %s WHERE product_id = %d ORDER BY date_created DESC ",
            self::DB_TABLE,
            $productID
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
