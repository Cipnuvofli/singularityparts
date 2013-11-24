

<div id = "Product Creation form">

<?php echo validation_errors(); ?>

<?php echo form_open('Product/create_product');?>

<p id = "Name">Product Name: <input type="text" name="name"></p>
<p id = "Manufacturer">Product Manufacturer: <input type="text" name="manufacturer"></p>
<p id = "Category">Product Category: <input type="text" name="category"></p>
<p id = "Price">Product Price: <input type="text" name="price"></p>
<p id = "Description">Product Description: <input type="text" name="Description"></p>
<p id = "Barcode">Product Barcode: <input type="text" name="Barcode"></p>
<p id = "Width">Product Width: <input type="text" name="Width"></p>
<p id = "Length">Product Length: <input type="text" name="Length"></p>
<p id = "Height">Product Height: <input type="text" name="Height"></p>
<p id = "Weight">Product Weight: <input type="text" name="Weight"></p>


<input type="submit" value="Create" />
</form>

                         

</div>


