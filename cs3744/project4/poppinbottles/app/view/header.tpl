<!DOCTYPE html>
<html lang="en">	
	<head>
		<meta charset="utf-8">
		<meta name="Description" content="Wine Producer and Seller">
		<title> BottleUp </title>
		
	    <link rel="stylesheet" type="text/css" href="<?= BASE_URL ?>/public/css/styles.css">
  		<script type="text/javascript" src="<?= BASE_URL ?>/public/js/jquery-3.1.0.min.js"></script>
  		<script type="text/javascript" src="<?= BASE_URL ?>/public/js/scripts.js"></script>		
	    
	</head>

	<body>
		<div id="header">
			<a href="<?= BASE_URL ?>/">
			<h1>
				BottleUp	
			</h1>
			</a>
			<!-- Logo source: https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=0ahUKEwik_ca606zPAhVFPz4KHdFUALIQjxwIAw&url=http%3A%2F%2Fdownloadicons.net%2Fwine-glass-icons%3Fpage%3D1&bvm=bv.133700528,d.amc&psig=AFQjCNFL5ltrmsUGtfqWro2LycqPJwtrLg&ust=1474966206374946 -->
			<img class="logo" src="<?= BASE_URL ?>/public/img/wine.png" alt="Logo" />

			<?php session_start(); if(isset($_SESSION['adminLogin'])): ?>
			  <form  id="login" action="<?= BASE_URL ?>/processLogout">
				<input type="submit" value="Logout" class="submit logForm" >
				<input type="button" value="Cart" class="submit" />
			  </form>
			<?php else: ?>
			  <form  id="login" action="<?= BASE_URL ?>/processLogin" method="POST"  >
				<input type="text" name="username" class="inputForm user" placeholder="Username: ">
				<input type="password" name="password" class="inputForm pass" placeholder="Password: ">
				<input type="submit" value="Submit/Register" class="submit logForm" >
				<input type="button" value="Cart" class="submit" />
			  </form>
			<?php endif; ?>

			<?php
			function isSelected($pn, $link) {
				if($pn == $link) {
					return ' id="selected-nav" ';
				}
			}
			?>

			<ul class="primary-nav">
				<li><a <?= isSelected($pageName, 'Home') ?> href="<?= BASE_URL ?>/">Home</a></li>
				<li><a <?= isSelected($pageName, 'browse') ?> href="<?= BASE_URL ?>/browse/">Browse</a></li>
				<li><a <?= isSelected($pageName, 'aboutUs') ?> href="<?= BASE_URL ?>/aboutUs/">About Us</a></li>
				<li><a <?= isSelected($pageName, 'locations') ?> href="<?= BASE_URL ?>/locations/">Find Locations</a></li>
				<?php if(isset($_SESSION['adminLogin'])): ?>
				<li><a <?= isSelected($pageName, 'addItem') ?> href="<?= BASE_URL ?>/addItem">Add Item</a></li>
				<?php endif; ?>
			</ul>	

			<?php
				if(!isset($_SESSION)) 
				{ 
				    session_start(); 
				} 

				if(isset($_SESSION['adminLogin'])) {
					echo '<p>Logged In As Admin: '.$_SESSION['adminLogin'].'</p>';
				}
			?>
			
			<form action="<?= BASE_URL ?>/search/" id="search" >
				<input type="submit" name="Search"  value="Search the internet for Wine!" class="inputForm submit"> 
			</form>

		</div>	