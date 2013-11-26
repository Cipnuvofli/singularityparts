<div id = "Products">

<?php
	$products = $this->Cart_model->get_products(array());
	$this->Cart_model->GenerateProductStubsForResult($products);?>



</div>


</body>