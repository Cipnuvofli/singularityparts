<?php

//This view is based on the tutorial in the Codeigniter documentation at http://ellislab.com/codeigniter%20/user-guide/libraries/cart.html
 echo form_open('Cart/update'); ?>

<table cellpadding="6" cellspacing="1" style="width:100%" border="0">

<tr>
  <th id = "QTY">QTY</th>
  <th id = "IDesc">Item Description</th>
  <th style = "Text-align:right">Item Price</th>
  <th style = "Text-align:right">Sub-Total</th>
</tr>

<?php $i = 1; ?>

<?php foreach ($this->cart->contents() as $items): ?>

	<?php echo form_hidden($i.'[rowid]', $items['rowid']); ?>

	<tr>
	  <td>
		<?php echo form_dropdown(
			$items['rowid'],
			range(0,$max_qty[$items['rowid']]), 
			$items['qty']
		)
		?>
	  </td>
	  <td>
		<?php echo $items['name']; ?>

			<?php if ($this->cart->has_options($items['rowid']) == TRUE): ?>

				<p>
					<?php foreach ($this->cart->product_options($items['rowid']) as $option_name => $option_value): ?>
						
						<strong><?php echo $option_name;  ?>:</strong> <?php echo $option_value; ?>

					<?php endforeach; ?>
				</p>

			<?php endif; ?>

	  </td>
	  <td style="text-align:right"><?php echo $this->cart->format_number($items['price']); ?></td>
	  <td style="text-align:right">$<?php echo $this->cart->format_number($items['subtotal']); ?></td>
	</tr>

<?php $i++; ?>

<?php endforeach; ?>

<tr>
  <td colspan="2"> </td>
  <td class="right"><strong>Total</strong></td>
  <td class="right">$<?php echo $this->cart->format_number($this->cart->total()); ?></td>
</tr>

</table>

<p><?php echo form_submit('', 'Update your Cart'); ?></p>
<br/><br/>
<p><?php echo anchor('FI', 'Checkout'); ?></p>
