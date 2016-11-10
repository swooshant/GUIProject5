<?php

include_once '../global.php';

//identifier using get for what we want to do
$action = $_GET['action'];

//creates new class and routes based on action
$pc = new ProductController();
$pc->route($action);

class ProductController {

	// route us to the appropriate class method for this action
	public function route($action) {
		//start a session if it's not set
		if (!isset($_SESSION)) {
			session_start();
		}
		switch($action) {
			case 'viewProduct':
				$productID = $_GET['pid'];
				$this->viewProduct($productID);
			break;

			case 'processEditDel':
				$productID = $_GET['pid'];
				if (isset($_POST['delete'])) {
				   	$this->delete($productID);
				} 
				else if(isset($_POST['edit'])){
				    $this->editProduct($productID);
				}
			break;

			case 'editProductProcess':
				$productID = $_GET['pid'];
				$this->editProductProcess($productID);
			break;
			case 'addItem':
				$this->addItem();
			break;
			case 'addItemProcess':
				$this->addItemProcess();
			break;
			case 'postCart':
				//either clear cart or add item to cart session.
				$productID = $_POST['id'];
				if ($productID == 'clear') {
					$this->clearCart();
				}
				else {
					$this->sessionPost($productID);
				}
			break;
			case 'addToCart':
				$this->addToCart();
			break;
			case 'addReview':
				$productID = $_GET['pid'];
				$this->addReview($productID);
			break;
			//default case to home
			default:
				header('Location: '.BASE_URL);
			exit();
		}

	}

	//displays an exact product in the product display page.
	//retieves the data from the database
	public function viewProduct($id) {
		$pageName = 'Product';
		$product = Product::loadById($id);
		$reviews = Review::getReviewsByProductId($id);

		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/product.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
	}

	//deletes a specific item from the database
	public function delete($id)
	{
		$conn = mysql_connect(DB_HOST, DB_USER, DB_PASS)
		or die ('Error: Could not connect to MySql database');
		mysql_select_db(DB_DATABASE);

		$q = sprintf("DELETE FROM product WHERE id = %d;",
			$id
			);

		$result = mysql_query($q);
		if (!$result) {
			echo "Delete Failed";
			exit();
		}
		header('Location: '.BASE_URL);
	}


	//displays the additem page, only when admin is logged in
	public function addItem(){
		$pageName = 'addItem';
		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/addProduct.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
	}

	//the process for adding an item to the database
	public function addItemProcess(){
		$newProduct = new Product();
		$creator_id = $_SESSION['userID'];

		$newProduct->set('WineTitle', $_POST['WineTitle']);
		$newProduct->set('ShortDesc', $_POST['ShortDesc']);
		$newProduct->set('LongDesc', $_POST['LongDesc']);
		$newProduct->set('Volumes', $_POST['Volumes']);
		$newProduct->set('Price', $_POST['Price']);
		$newProduct->set('Rating', $_POST['Rating']);
		$newProduct->set('Img_Url', $_POST['Img_Url']);
		$newProduct->set('Creator_Id', $creator_id);

		$newProduct -> save();
		header('Location: '.BASE_URL.'/addItem/');

	}

	//shows the edit page with database data loaded for the specific product
	public function editProduct($id) {
		$pageName = 'Edit Product';
		
		$product = Product::loadById($id);

		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/editProduct.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
	}

	//the process of changing the values in the database
	public function editProductProcess($id) {	
		$product = Product::loadById($id);
		$creator_id = $_SESSION['userID'];
		$title = $_POST['WineTitle'];

		$product->set('id', $id);
		// $product->set('WineTitle', $_POST['WineTitle']);
		$product->set('ShortDesc', $_POST['ShortDesc']);
		$product->set('LongDesc', $_POST['LongDesc']);
		$product->set('Volumes', $_POST['Volumes']);
		$product->set('Price', $_POST['Price']);
		$product->set('Rating', $_POST['Rating']);
		$product->set('Img_Url', $_POST['Img_Url']);
		$product->set('Creator_Id', $creator_id);


		// did the title change?
		if($product->get('title') != $title) {

			// log the event
			$e = new Event(array(
					'event_type_id' => EventType::getIdByName('edit_product_title'),
					'user_1_id' => $_SESSION['userID'],
					'product_1_id' => $id,
					'data_1' => $product->get('WineTitle'),
					'data_2' => $title
			));

			// change the title
			$product->set('WineTitle', $title);
			$e->save();
		}
		$product->save();
	    	header('Location: '.BASE_URL.'/browse/');
	}

	//retrieves the id from a post and puts it into a cart session
	//puts all the product infromation as JSON into cart session
	public function sessionPost($id){
		$cart = Product::loadById($id);

		$product['WineTitle'] = $cart->get('WineTitle');
		$product['ShortDesc'] = $cart->get('ShortDesc');
		$product['LongDesc'] = $cart->get('LongDesc');
		$product['Volumes'] = $cart->get('Volumes');
		$product['Price'] = $cart->get('Price');
		$product['Rating'] = $cart->get('Rating');
		$product['Date_Created'] = $cart->get('Date_Created');
		$product['Img_Url'] = $cart->get('Img_Url');
		
		$productJSON = json_encode($product);
		header('Content-Type: application/json');

		//if session cart not set, create an empty one.
		if (!isset($_SESSION['cart'])) {
			$_SESSION['cart'] = [];
		}

		array_push($_SESSION['cart'], $productJSON);

		echo $productJSON;

	}

	/*
	 * function addToCart
	   returns all the products in the cart as a json  
	 */
	public function addToCart(){
			header('Content-Type: application/json');
			
			$productJSON = json_encode($_SESSION['cart']);
			echo $productJSON;
	}

	/*
	 * function clearCart() clears the cart of all items 
	 	by returning unsetting the session 
	 */
	public function clearCart() {
		unset($_SESSION['cart']);
		header('Content-Type: application/json');

		$productJSON = json_encode($_SESSION['cart']);
		echo $productJSON;
	}

	public function addReview($productID) {

		$rating = $_POST['rating'];
		$review = $_POST['review'];
		$reviewerID = $_SESSION['userID']; // the logged-in user

		// create and save the new product review
		$nr = new Review(array(
			'rating' => $rating,
			'review' => $review,
			'reviewer_id' => $reviewerID,
			'product_id' => $productID
		));
		$nr->save();

		// redirect us
		header('Location: '.BASE_URL.'/products/view/'.$productID);
		exit();
	}
	
}
