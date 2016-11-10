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

	<p class="aboutUsParagraph"> 
		We are an online retailer as well as a high volume producer of wine. We have three distinct winery's located accross the United States. The first two are in Nappa Valley and the third one is in Virginia. You can view the winery's on the home page. We do everything from growing the grapes to bottling and shipping. Lastly, we provide the highest quality of wine from other producers.
	</p>

	<h2 class="aboutUsHeadings" > My Orders </h2> <!-- Past Products -->
	<h2 class="aboutUsHeadings" > My Listings </h2> <!-- My Listings -->
	<h2 class="aboutUsHeadings" > Followers </h2> <!-- Followers -->
	<h2 class="aboutUsHeadings" > Following </h2> <!-- Following -->

	<?php if(isset($events)): ?>

		<h2 class="aboutUsHeadings" > Activity Feed </h2> <!-- Actions of people that you follow as well as yourself -->

		<?php if(count($events) == 0): ?>
			<p>No recent activity.</p>
		<?php else: ?>

		<ul>
			<?php foreach($events as $event): ?>
		    		<li><?= formatEvent($event) ?></li>
		  	<?php endforeach; ?>
		</ul>

		<?php endif; ?>
		
	<?php endif; ?>

</div>