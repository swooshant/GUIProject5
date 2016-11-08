<?php

include_once '../global.php';

// get the identifier for the page we want to load
$action = $_GET['action'];

//does the site controlling, separate from the products
$pc = new SiteController();
$pc->route($action);

//routes to the right place based on the action from the .htaccess
class SiteController {
	public function route($action) {

		switch($action) {
			case 'home':
				$this->home();
			break;
			case 'aboutUs':
				$this->aboutUs();
			break;
			case 'processLogin':
				$username = $_POST['username'];
				$password = $_POST['password'];
				$this->processLogin($username, $password);
			break;
			case 'processLogout':
				$this->processLogout();
			break;
			case 'browse' :
				$this->browse();
			break;
			case 'processNewsLetter' :
				$this->processNewsLetter();
			break;
			case 'locations' :
				$this->locations();
			break;
			case 'search': 
				$this->searchPage();
			break;
				// Defaults to homepage url
      		default:
        			header('Location: '.BASE_URL);
        			exit();
		}
	}

	//loads home page and also the top rated items
  	public function home() {
		$pageName = 'Home';
		
		// load the top rated into results, to be used by home.tpl
		$conn = mysql_connect(DB_HOST, DB_USER, DB_PASS)
			or die ('Error: Could not connect to MySql database');
		mysql_select_db(DB_DATABASE);
		$q = "SELECT * FROM product ORDER BY Rating DESC LIMIT 0, 5; ";
		$result = mysql_query($q);

		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/home.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
	}

	//Browse page with all the items from the database
	public function browse() {
		$pageName = 'browse';

		// load the top rated into results, to be used by home.tpl
		$conn = mysql_connect(DB_HOST, DB_USER, DB_PASS)
			or die ('Error: Could not connect to MySql database');
		mysql_select_db(DB_DATABASE);
		$q = "SELECT * FROM product ORDER BY Date_Created DESC";
		$result = mysql_query($q);

		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/browse.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
	}

		//simple about us page
	public function aboutUs() {
		$pageName = 'aboutUs';
		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/aboutUs.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
  	}

	  //takes user to page to find locaitons near them
	public function locations() {
	  	$pageName = 'locations';
	  	include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/location.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
	}

  	//gets admin data (id 1) and checks against it to let a login happen
	public function processLogin($u, $p) {
		$pageName = 'processLogin';

		$userObj = new User();
        $adminObj = $userObj -> loadById(1);

		$adminUsername = $adminObj->getUsername();
		$adminPassword = $adminObj->getPassword();

		if(($u == $adminUsername) && ($p == $adminPassword)) {
			session_start();
			$_SESSION['adminLogin'] = $u;
			header('Location: '.BASE_URL);
			exit();
		}
		header('Location: '.BASE_URL);

	}


	//just destroys the admin login
	public function processLogout() {
		session_start(); 
		if(isset($_SESSION['adminLogin'])){
			session_destroy();
			header('Location: '.BASE_URL);
		}
	}
	
	//adds users to the newsletter table
	public function processNewsLetter() {
		$newsLetterUsers = new Newsletter();

		$newsLetterUsers->set('Name', $_POST['name']);
		$newsLetterUsers->set('Email', $_POST['email']);

		$newsLetterUsers->save();
		header('Location: '.BASE_URL);

	}

	
	// function to geocode address, it will return false if unable to geocode address
	function geocode($address) {
	 
	    // url encode the address
	    $address = urlencode($address);
	     
	    // google map geocode api url
	    $url = "http://maps.google.com/maps/api/geocode/json?address={$address}";https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&type=restaurant&keyword=cruise&key=AIzaSyAWgxNoCo1FVZSm6azr-hXBV9Okvmzz3uI
	 
	    // get the json response
	    $resp_json = file_get_contents($url);
	     
	    // decode the json
	    $resp = json_decode($resp_json, true);
	 
	    	// response status will be 'OK', if able to geocode given address 
	    	if($resp['status']=='OK') {
	 
		      // get the important data
		      $lati = $resp['results'][0]['geometry']['location']['lat'];
		      $longi = $resp['results'][0]['geometry']['location']['lng'];
		      $formatted_address = $resp['results'][0]['formatted_address'];
	         
		      // verify if data is complete
		      if($lati && $longi && $formatted_address)
		      {   
		            // put the data in the array
		            $data_arr = array();            
		             
		            array_push(
		                $data_arr, 
		                    $lati, 
		                    $longi, 
		                    $formatted_address
		                );
		             
		            return $data_arr; 
		      }
		      else
		      {
		            return false;
		      }  
		}
	      else
	      {
	      	return false;
	      }
	}
	
	//Loads the templates for the search page
	public function searchPage(){
		include_once SYSTEM_PATH.'/view/header.tpl';
		include_once SYSTEM_PATH.'/view/search.tpl';
		include_once SYSTEM_PATH.'/view/footer.tpl';
	}
}








