{**
 * Aurelle Jewels product card: an Ivory plate with the square photo and its flag, then the name in the serif,
 * the metal and stone (Theme Kit card labels) as one quiet line, and the price with the metal colours.
 * @author iamshoaibktk@gmail.com  @license AFL-3.0
 *}
{extends file='parent:catalog/_partials/miniatures/product.tpl'}

{* Colours are shown at the end of the price row. *}
{block name='product_variants'}{/block}

{block name='product_discount_price'}
  {if $product.has_discount}
    <span class="product-miniature__regular-price" aria-label="{l s='Regular price' d='Shop.Theme.Catalog'}">{$product.regular_price}</span>
  {/if}
  {if $product.main_variants}<span class="product-miniature__variants au-card__dots">{include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}</span>{/if}
{/block}
