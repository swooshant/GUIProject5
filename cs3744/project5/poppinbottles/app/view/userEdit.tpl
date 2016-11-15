<?php if(isset($_SESSION['admin']) &&  $_SESSION['admin'] == 1): ?>
	<div id="bodyWrapper">
			<?php if($allUsers == null): ?>
				<h4 class="reviewHeader"> No Users are in the database.</h4> 
			<?php else: ?>
				<?php foreach($allUsers as $user): ?>
					<?php
						if(!$user->get('is_admin')){
							$username = $user->get('username');
							$uid = $user->get('id');
							$elite = $user->get('is_elite');
						}
					?>

				<?php if(!$user->get('is_admin')): ?>
				<div id="userEditWrapper">
					<br>
					<li style="list-style: none;""> <?= $username?> </li>
						<?php if($elite): ?>
							<form id="<?=$username?>" method="POST" action="<?= BASE_URL ?>/updateElite/">
							<input id="<?=$username?>" class="changeUser" type="radio" name="radioName" value= "<?=$username?> elite" checked="checked">Elite
							<input  id="<?=$username?>" class="changeUser" type="radio" name="radioName" value= "<?=$username?> regular">Regular<br><br>
							</form>
						<?php else: ?>
							<form id="<?=$username?>" method="POST" action="<?= BASE_URL ?>/updateElite/">
							<input id="<?=$username?>" class="changeUser" type="radio" name="radioName" value= "<?=$username?> elite" >Elite
							<input  id="<?=$username?>" class="changeUser" type="radio" name="radioName" value= "<?=$username?> regular" checked="checked" >Regular <br><br>
							</form>
						<?php endif; ?>
					
				</div>
				<?php endif; ?>

			<?php endforeach; ?>

			<?php endif; ?>	
	</div>
<?php else: ?>
	<hr>
	<h1 style="color:red"> Need To be Admin! </h1>
<?php endif; ?>
