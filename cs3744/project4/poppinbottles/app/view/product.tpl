<h1><a class="back" href="<?= BASE_URL ?>/browse/"> <<< back </a></h1>
	<div id="prodcontent-left">
			<form  action="<?= BASE_URL ?>/products/processEditDel/<?= $product['id'] ?>" method="POST" >
				<img src="<?= BASE_URL ?>/public/img/<?= $product['Img_Url'] ?>" alt="Wine product chosen">
				<br>
				<?php if(isset($_SESSION['adminLogin'])): ?>
						  		<button class="submit" name="edit" value="editPressed" >Edit</button>
						  		<button class="submit" name="delete" onclick="return confirm('Are you sure you want to delete this item?');" value="deletePressed">Delete</button>
				<?php endif; ?>
				<h2><?= $product['WineTitle'] ?></h2>
				<!-- reviews from Trip ADvisor!! -->
				<!-- ALL Descriptions are from TotalWine.com -->
				<h4> <?= $product['ShortDesc'] ?> </h4>
				<h3 class="price">Price: <?= $product['Price'] ?></h3>
				<p class="pdescriptions">
					<?= $product['LongDesc'] ?>
				</p>
			</form>
		</div>
		<div id="prodcontent-right">
			
			<div class="dropdown" id="size">
				<h3>Sizes:</h3>
				<?= $product['Volumes'] ?>
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

			<button class="submit">Add to Cart</button>
			<h3> Rating: <?= $product['Rating'] ?>/5.0 </h3>

			<div id="revieWrapper">
				<div class="reviews">
					<h4 class="reviewHeader">
						User123: Rating: *****: <?= $product['Date_Created'] ?>
					</h4>
					<p class="reviewParagraph">
								<!-- reviews from Trip ADvisor!! -->

						The Wine Experience is the only way to see and learn about wineries in Uruguay. Ryan was amazing. He customizes your tour to the time you have, the type of wine tour you want, where you want to go and how long you want to be gone. He will accomodate you any way you need. We wanted to see Colonia and include the wine tasting and cheese tasting in this very famous cheese and wine area of Uruguay. We,3 of us, only had one day and Ryan made it happen without feeling rushed or pressured........We spent 2 and half hours in beautiful Colonia and had a light lunch before our tour started........18 wine tasting glasses and enough cheese tasting to compliment every glass of wine and more......then enjoying the ride back to Montevideo Ryan explained the region and history of the wines. AN AMAZING FULL AND ENJOYABLE DAY......We will be booking other areas of Uruguay with him and looking forward to his interesting stories of the different regions and the wines Uruguay has to offer. Just contact The Wine Experience and Ryan will make it happen!

					</p>
				</div>	
				<div class="reviews">
					<h4 class="reviewHeader">
						User999: Rating: ****: <?= $product['Date_Created'] ?>
					</h4>
					<p class="reviewParagraph">
								<!-- reviews from Trip ADvisor!! -->
						I recently moved to Bay Ridge and am still getting to know the area. I was planning a small party for my mom and aunt visiting from the south and needed to get some supplies. I needed a mixed selection and only knowing slightly more than the basics of wine is made of grapes and whisky is dark can be frustrating. 

						Joe helped me out and took his time making suggestions and comparisons. I was planning on buying a bottle of tequila for my aunt as one of her birthday gifts - I recalled her liking a certain brand but they were out. I was given the suggestion of 123 Organic Reposado (Dos) as well as an orange liqueur incase someone wanted to make a margarita. My mom likes her gin & tonics so he recommended Hendrick's (a name I was aware of but I am not a gin drinker) . 

						I also wanted/needed bottles of chardonnay from a local vineyard, vodka & a celebratory bottle of sparkling wine to pop. Joe also asked about my budget and we were able to compromise so I was able to get the best selection for my budget. I went in on a Wednesday night around 6:30/7pm, requested delivery around 8/8:30 and was able to get the delivery at 8pm on the dot. 

						Everything was a hit! My aunt loved her tequila (so did my mom apparently) and was very impressed. My mom loved her gin. The only thing left is 1/2 a bottle of the orange liqueur.. Here I was worried that I may have bought too much but I was way off, I actually should have bought more. 

						So I'll be back soon to pick out more so that 1/2 bottle of orange liqueur isn't so lonely. 
					</p>
				</div>	
			</div>
	</div>
