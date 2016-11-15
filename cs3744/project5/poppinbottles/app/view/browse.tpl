
<div id = "browseContainer">
	<div id="sidebar">


		<h3>Search Filters</h3>

		<h4>Grapes:</h4>
		<label><input type="checkbox" name="Grape" value="Pinot Noir" /> Pinot Noir</label>
		<label><input type="checkbox" name="Grape" value="Zinfindel" checked="checked" /> Zinfindel</label>
		<label><input type="checkbox" name="Grape" value="Pinot Grigio" checked="checked" /> Pinot Grigio</label>
		<label><input type="checkbox" name="Grape" value="Malbec" /> Malbec</label>
		<h4>Size:</h4>
		<label><input type="checkbox" name="size" value="1.75L" checked="checked" /> 1.75L</label>
		<label><input type="checkbox" name="size" value="1L" /> 1L</label>
		<label><input type="checkbox" name="size" value="750mL" /> 750mL</label>
		<label><input type="checkbox" name="size" value="350mL" /> 350mL</label>

		<button class="submit">Update filters</button>

	</div>

	<div id="cart">

		<h3>Cart</h3>
		
		<div id = "cartItems"></div>
		<script type="text/javascript">

		     /*
			* updateTheCart() function will get the JSON from the specified url and add those JSON elements to the page.
			*/
			function updateTheCart() {
				var $cart = $('#cartItems');
				$.ajax(
				{
					url: "<?= BASE_URL ?>"+ "/products/updateCart/",
					type: "GET",
					
					success: function(result)
					{
						var totalCost = 0.0;
						$cart.empty(); // clears all the li tags in the cartItems div

						$.each(result, function(i, item) {
							var json = JSON.parse(item); // converts Array to JSON
							$cart.append('<li style="color:green; list-style: none;" >' + json.WineTitle + ', Price: $' + json.Price + ', Quantity: ' + json.Quantity +'</li>' + '<br>'); //adds wine item to the cart
							totalCost = totalCost + (parseFloat(json.Price) * parseFloat(json.Quantity));
						});
						
						var userID = "<?= $_SESSION['userID'] ?>";

						if(!$.isEmptyObject(result)){
							$cart.append('<h5>' + 'Total Cost: $' + (Math.round(totalCost * 100) / 100) + '</h5>');
						}
						else if(!userID) {
							$cart.append('<h4 style="color:red;" >' + 'Log In to Add to Cart' + '</h4>');
						}
						else{	
							$cart.append('<h4 style="color:blue;" >' + 'Your Cart is Empty' + '</h4>');
						}

					},
					error: function() {
						alert('error when updating the cart.');
					}
				}
				);
			}

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
						updateTheCart(); //update the layout of the cart asynchronously
					},
					error: function(xhr, status, error) {
						//var err = eval("(" + xhr.responseText + ")");
						alert('error when posting to session.');
					}
				});
			}

		     /*
			* clearCart() function will clear the contents of the chart
			*/
			function clearCart() {
				var $cart = $('#cartItems');

				var cartData = {
					'id': 'clear'
				};

				$.ajax(
				{				
					type: "POST",
					url: "<?= BASE_URL ?>"+ "/products/updatePostCart/",
					data: cartData,
					success: function(result) {
						$cart.empty(); // removes all the li tags in the cart div
						updateTheCart(); // updates the cart to show an empty cart
					},
					error: function(xhr, status, error) {
						var err = eval("(" + xhr.responseText + ")");
						alert(err.Message);
					}
				});
			}

		     /*
			* updates the cart when the page is loaded
			*/
			$(document).ready(function () {
				updateTheCart();
			});

		</script>

		<button class="submit" onclick= "clearCart()">Clear Cart</button>

	</div>

	<div id="browseContent">
		<!-- All descriptions, wine names and images are from TotalWine.com -->
		<div class="rows">	

			<?php while($row = mysql_fetch_assoc($result)): ?>
				<form action="<?= BASE_URL ?>/products/processEditDel/<?= $row['id'] ?>" method="POST" >
					<!-- All descriptions, wine names and images are from TotalWine.com -->
					<div class="product">
						<a href="<?= BASE_URL ?>/products/view/<?= $row['id'] ?>">
							<img class="product-image" src="<?= BASE_URL ?>/public/img/<?= $row['Img_Url'] ?>" alt="<?= $row['title'] ?>" />
							<h3><?= $row['WineTitle'] ?></h3>
						</a>
						<button class="submit" type="button" id = "updateCart" value="cartPressed" onclick="postToSession(<?=$row['id']?>)"> Add to Cart</button>
						<p class="shortdesc"><?= $row['ShortDesc'] ?></p>
						<p class="price"><?= $row['Price'] ?></p>
						<?php if(isset($_SESSION['admin']) && $_SESSION['admin'] == 1): ?>
							<button class="submit" name="edit" value="editPressed" >Edit</button>
							<button class="submit" name="delete" onclick="return confirm('Are you sure you want to delete this item?');" value="deletePressed">Delete</button>
						<?php elseif(isset($_SESSION['elite']) && $_SESSION['elite'] == 1 && ($_SESSION['userID'] == $row['Creator_Id'])): ?>							
							<button class="submit" name="edit" value="editPressed" >Edit</button>
							<button class="submit" name="delete" onclick="return confirm('Are you sure you want to delete this item?');" value="deletePressed">Delete</button>
						<?php endif; ?>

					</div>
				</form>
			<?php endwhile; ?>
		</div>
	</div>
</div>




