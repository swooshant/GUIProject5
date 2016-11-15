<div id="bodyWrapper">
	<h2 class="aboutUsHeadings" > My Profile </h2>
	<p>
		<b>Name: </b>
		<?= $user->get('first_name')." ".$user->get('last_name')?>
		<br><br>
		<b>Email: </b>
		<?= $user->get('email') ?>
		<br><br>
		<b>Username: </b>
		<?= $user->get('username') ?>
		<br><br>
		<b>Account Type: </b>
		<?php 
			if ($user->get('is_admin') == 1)
			{
				echo "Admin";
			}
			else if ($user->get('is_elite') == 1)
			{
				echo "Elite";
			}
			else
			{
				echo "Regular";
			}
		?>
		<!--Elite-->
		<br><br>
		<b style="color:maroon">Change password</b>
		<form action="<?= BASE_URL ?>/profilePage/updateProfile" method="POST">
			New password:
			<br>
			<input type="password" name="newPassword1" class = "inputForm">
			<br>
			Confirm password:
			<br>
			<input type="password" name="newPassword2" class = "inputForm">
			<br>
			<br>
			
			<b style="color:maroon">Change Account Type</b>
			<?php 
			if ($user->get('is_admin') == 1)
			{
				//don't show account type

				echo '<select name="accountType">
						<option value="admin" selected>Admin</option>
			    	<option value="elite" >Elite</option>
			    	<option value="regular">Regular</option>
					</select> <br><br>';
			?>

				<button class="submit" name="submit" onclick="return confirm('Warning: you are an admin. Are you sure want to update your changes? Note: You cannot change back to an admin account from an elite/regular account.');">Save Changes</button>
			<?php
			}
			else if ($user->get('is_elite') == 1)
			{
			 echo '<select name="accountType">
			    	<option value="elite" selected>Elite</option>
			    	<option value="regular">Regular</option>
				</select><br><br>
				<button class="submit" name="submit" value="Save Changes");>Save Changes</button>';
			}
			else
			{
				echo '<select name="accountType">
			    	<option value="elite" >Elite</option>
			    	<option value="regular" selected>Regular</option>
				</select><br><br>
				<button class="submit" name="submit" value="Save Changes");>Save Changes</button>';
			} ?>
			<br><br>
			<!--<input type="submit" name="submit" value="Save Changes" class = "submit">-->
		</form>
		<?php if (isset($_SESSION['profile']))
			{
				echo "<div id='message' style='color:blue'>". $_SESSION['profile']."</div>";
				unset($_SESSION['profile']);
			}
		?>
	</p>
	<h2 class="aboutUsHeadings" > My Cart </h2> <!-- Current Products -->

		<?php
			$cartProducts = Cart::getCartProducts($user->get('id'));
			$cartQuantities = Cart::getCartQuantities($user->get('id'));

			for ($i = 0; $i < count($cartProducts); $i++) {
				$productID = Product::loadById($cartProducts[$i])->get('id');
				$productTitle = Product::loadById($cartProducts[$i])->get('WineTitle');
				$productPrice = Product::loadById($cartProducts[$i])->get('Price');

				echo '<br> <li style="list-style: none; color: green;">Name: <a href="'.BASE_URL.'/products/view/'.$productID.'">'.$productTitle.'</a>, Price: '.$productPrice.', Quantity: '.$cartQuantities[$i].'</li>';
			}
		?>

	<h2 class="aboutUsHeadings" > My Orders </h2> <!-- Past Products -->
	<h2 class="aboutUsHeadings" > My Listings </h2> <!-- My Listings -->
		<ul>
			<?php
				$listingArray = array();
				$listingArray = Product::getByCreator($user->get('id'));

				for ($i = 0; $i < count($listingArray); $i++) {
					echo '<li style="list-style: none;">'.$listingArray[$i].'</li>';
				}
			?>
		</ul>
	<h2 class="aboutUsHeadings" > Followers </h2> <!-- Followers -->
		<ul>
			<?php
				$followersArray = array();
				$followersArray = Follow::getFollowers($user->get('id'));

				for ($i = 0; $i < count($followersArray); $i++) {
					echo '<li style="list-style:none;font-weight:bold">'.$followersArray[$i].'</li>';
				}
			?>
		</ul>
	<h2 class="aboutUsHeadings" > Following </h2> <!-- Following -->
		<ul>
			<?php
				$followingArray = array();
				$followingArray = Follow::getFollowing($user->get('id'));

				for ($i = 0; $i < count($followingArray); $i++) {
					echo '<li style="list-style: none; color:black; font-weight: bold;" 
							class="unfollow'.$followingArray[$i].'">'.$followingArray[$i].' 
							<button type="button" class="unfollow submit" value="'.$followingArray[$i].'">Unfollow
							</button>
						</li>';
				}
			?>
		</ul>
	<?php if(isset($events)): ?>

		<h2 class="aboutUsHeadings" > Activity Feed </h2> <!-- Actions of people that you follow as well as yourself -->

		<?php if(count($events) == 0): ?>
			<p>No recent activity.</p>
		<?php else: ?>

		<ul>
			<?php foreach($events as $event): ?>
		    		<li  style="list-style: none; color:blue; font-weight: bold;" ><?= formatEvent($event) ?></li>
		  	<?php endforeach; ?>
		</ul>

		<?php endif; ?>
		
	<?php endif; ?>

</div>