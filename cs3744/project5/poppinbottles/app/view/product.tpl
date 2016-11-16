<h1><a class="back" href="<?= BASE_URL ?>/browse/"> <<< back </a></h1>
<script type="text/javascript">
	/*
			* postToSession(id) function will post the specific id of the wine item that is clicked on to the specified url 
			*/
			function postToSession(id) {
				var $cart = $('#cartItems'); // gets the cartItems div

				var cartData = {
					'id': id
				};

				$.ajax(
				{				
					type: "POST",
					url: "<?= BASE_URL ?>"+ "/products/updatePostCart/",
					data: cartData,
					success: function(result) {
						//updateTheCart(); //update the layout of the cart asynchronously
					},
					error: function(xhr, status, error) {
						//var err = eval("(" + xhr.responseText + ")");
						alert('error when posting to session.');
					}
				});
			}
</script>
<div id="bodyWrapper">
	<div id="prodcontent-left">
			<form  action="<?= BASE_URL ?>/products/processEditDel/<?= $product->get('id') ?>" method="POST" >
				<img src="<?= BASE_URL ?>/public/img/<?= $product->get('Img_Url') ?>" alt="Wine product chosen">
				<br>
				<form action="<?= BASE_URL ?>/products/processEditDel/<?= $product->get('id') ?>" method="POST" >
					<?php if(isset($_SESSION['admin']) && $_SESSION['admin'] == 1): ?>
				  	<button class="submit" name="edit" value="editPressed" >Edit</button>
				  	<button class="submit" name="delete" onclick="return confirm('Are you sure you want to delete this item?');" value="deletePressed">Delete</button>
					<?php elseif(isset($_SESSION['elite']) && $_SESSION['elite'] == 1 && ($_SESSION['userID'] == $product->get('Creator_Id'))): ?>
						<button class="submit" name="edit" value="editPressed" >Edit</button>
				  	<button class="submit" name="delete" onclick="return confirm('Are you sure you want to delete this item?');" value="deletePressed">Delete</button>
					<?php endif; ?>
				</form>
				<h2><?= $product->get('WineTitle') ?></h2>
				<!-- reviews from Trip ADvisor!! -->
				<!-- ALL Descriptions are from TotalWine.com -->
				<h4> <?= $product->get('ShortDesc') ?> </h4>
				<h3 class="price">Price: <?= $product->get('Price') ?></h3>
				<p class="pdescriptions">
					<?= $product->get('LongDesc') ?>
				</p>
			</form>
		</div>
		<div id="prodcontent-right">
			
			<div class="dropdown" id="size">
				<h3>Sizes:</h3>
				<?= $product->get('Volumes') ?>
				<br>
				<h3>Quantity:</h3> 
				<select name="Quantity">
				  <option value="1">1</option>
				  <option value="2">2</option>
				  <option value="3">3</option>
				  <option value="4">4</option>
				  <option value="5">5</option>
				  <option value="6">6</option>
				  <option value="more">...</option>
				</select>
			</div>

			<!-- <button class="submit">Add to Cart</button> -->
			<button class="submit" type="button" id = "updateCart" value="cartPressed" onclick="postToSession(<?=$product->get('id')?>)"> Add to Cart</button>
			
			<?php if(isset($_SESSION['userID'])): ?>
				<h3> <a href="#addReview"> Add a Review! </a></h3>
			<?php endif; ?>

			<div id="revieWrapper">
						<?php if($reviews == null): ?>
							<h4 class="reviewHeader"> No reviews of this product yet.</h4> 
						<?php else: ?>
							<?php foreach($reviews as $review): ?>
								<?php

									$stars = '';

									// full stars
									for($i=0; $i<$review->get('rating'); $i++) {
										$stars .= '&#9733;';
									}

									// empty stars
									for($i=0; $i<(5 - $review->get('rating')); $i++) {
										$stars .= '&#9734;';
									}
									$username = User::getUsernameById($review->get('reviewer_id'));
									$followButton = getFollowButton($username);
								?>
								<!-- dont forget to add follow code from line 70 end -->
								<!-- .= is a += but string concatenator -->
						<div class="review">
							<p class="rating">Rating: <?= $stars ?></p>
							<p class="reviewParagraph"><?= $review->get('review') ?></p>
							<p class="reviewParagraph">Posted by <strong><?= $username.$followButton ?></strong> on <?= date("m-j-y g:i a", strtotime($review->get('date_created'))) ?></p>
							<hr>
						</div>

					<?php endforeach; ?>

				<?php endif; ?>
				<!-- User123: Rating: *****: <?= $product->get('Date_Created') ?> -->
			</div>
		</div>
		<div id="addReview">
			<?php if(isset($_SESSION['userID'])): ?>

			<h2>Your review</h2>

			<form method="POST" action="<?= BASE_URL ?>/products/view/<?= $product->get('id') ?>/review/">

				<label>Rating:
				<select name="rating">
					<option value="0">0 stars (worst)</option>
					<option value="1">1 star</option>
					<option value="2">2 stars</option>
					<option value="3">3 stars</option>
					<option value="4">4 stars</option>
					<option value="5">5 stars (best)</option>
				</select>
				</label>
				<br><br>
				<label>Review: <br>
					<textarea name="review"></textarea>
				</label>
				<br>
				<input type="submit" name="submit" value="Post Review">

			</form>

			<?php endif; ?>
		</div>
	
</div>