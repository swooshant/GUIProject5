<?php

class Cart extends DbObject {
	   
	// name of database table
	const DB_TABLE = 'cart';

    	// database fields
    	protected $id;
    	protected $creator_id;
    	protected $product_id;
    	protected $product_count;

    	// constructor
	public function __construct($args = array()) {
      	$defaultArgs = array(
	            'id' => null,
	            'creator_id' => null,
	            'product_id' => null,
	            'product_count' => 0
      	);

	      $args += $defaultArgs;

	       $this->id = $args['id'];
	       $this->creator_id = $args['creator_id'];
	       $this->product_id = $args['product_id'];
	       $this->product_content = $args['product_count'];
    	}

    	// save changes to object
    	public function save() {
        	$db = Db::instance();
        	
        	// omit id and any timestamps
        	$db_properties = array(
	            'id' => $this->id,
	            'creator_id' => $this->creator_id,
	            'product_id' => $this->product_id,
	            'product_count' => $this->product_count
            );
        	$db->store($this, __CLASS__, self::DB_TABLE, $db_properties);
    	}

    	public static function getCartProducts($userID) {
		if($userID == null)
			return null;

	      $query = sprintf("SELECT * FROM %s WHERE creator_id = %d ",
	          self::DB_TABLE,
	          $userID
	        );
	      
	      $db = Db::instance();
	      $result = $db->lookup($query);
		
		if(!mysql_num_rows($result)) {
			return null;
		}
	      else {
	          	$objects = array();
	            while($row = mysql_fetch_assoc($result)) {
	                $objects[] = $row['product_id'];
	            }
	            return ($objects);
	      }
    	}

    	public static function getCartQuantities($userID) {
		if($userID == null)
			return null;

	      $query = sprintf("SELECT * FROM %s WHERE creator_id = %d ",
	          self::DB_TABLE,
	          $userID
	        );
	      
	      $db = Db::instance();
	      $result = $db->lookup($query);

		if(!mysql_num_rows($result)) {
			return null;
		}
	      else {
	          	$objects = array();
	            while($row = mysql_fetch_assoc($result)) {
	                $objects[] = $row['product_count'];
	            }
	            return ($objects);
	      }
    	}

    	public static function incrementQuantity($userID, $productID) {
    		if ($userID == null || $productID == null) {
    			return null;
    		}

		$query = sprintf(" UPDATE %s SET product_count =  product_count + 1 WHERE creator_id = %d AND product_id = %d ",
	            self::DB_TABLE,
	            $userID,
	            $productID
            );

	      $db = Db::instance();
	      $result = $db->lookup($query);

	      return $result;
    	}

    	public static function deleteItems($userID) {

		$query = sprintf(" DELETE FROM %s WHERE creator_id = %d ",
	            self::DB_TABLE,
	            $userID
	      );

	      $db = Db::instance();
	      $result = $db->lookup($query);
    	}
}