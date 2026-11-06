{**
 * Aurelle Jewels product page.
 * - Over the name: the reference and the house.
 * - Under "Add to bag": the gift line, then the promises (Theme Kit product note).
 * - Ring sizes: custom.js adds "Find your size" and the ring sizer panel under them, with the texts below.
 * - Under the photo and buy box: "The details" (the features as one ruled row, the description) and an accordion.
 * @author iamshoaibktk@gmail.com  @license AFL-3.0
 *}
{extends file='parent:catalog/product.tpl'}

{block name='product_header'}
  <p class="au-ref">{if $product.reference}{$product.reference|regex_replace:'/^([A-Za-z]+-[0-9]+)-[0-9]+$/':'$1'}{/if}{if $product.reference && !empty($product_manufacturer->name)} · {/if}{if !empty($product_manufacturer->name)}{$product_manufacturer->name}{/if}</p>
  {$smarty.block.parent}
{/block}

{block name='product_additional_info'}
  <p class="au-gift"><svg width="22" height="22" viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M3 9h18v4H3zM5 13h14v8H5zM12 9v12M12 9c-2-4-6-4-6-1s6 1 6 1zm0 0c2-4 6-4 6-1s-6 1-6 1z" fill="none" stroke="currentColor" stroke-width="1.4" stroke-linejoin="round"/></svg><span>{l s='Arrives in our gift box, with a card written by hand.' d='Modules.Hbkit.Shop'}</span></p>
  {$smarty.block.parent}
{/block}

{block name='product_tabs'}
  {* The ring sizer's texts, used by custom.js when the product has ring sizes. *}
  <template id="au-sizer-tpl">
    <button type="button" class="au-findsize js-au-find" aria-expanded="false">{l s='Find your size' d='Modules.Hbkit.Shop'}</button>
    <div class="au-sizer au-sizer--panel js-au-sizer" hidden>
      <div class="au-sizer__stage" aria-hidden="true"><span class="au-sizer__ring js-au-ring"></span><span class="au-sizer__mm js-au-mm"></span></div>
      <div class="au-sizer__side">
        <strong class="au-sizer__title">{l s='Lay a ring you own on the circle' d='Modules.Hbkit.Shop'}</strong>
        <p class="au-sizer__text">{l s='Choose sizes until the circle meets the inside of your ring.' d='Modules.Hbkit.Shop'} <span class="js-au-uk-us" data-format="{l s='Size [1] is UK [2], US [3].' d='Modules.Hbkit.Shop'}"></span></p>
        <p class="au-sizer__note">{l s='Approximate on some screens. Free resizing within 60 days.' d='Modules.Hbkit.Shop'}</p>
      </div>
    </div>
  </template>
  <section class="au-details" aria-labelledby="au-details-title">
    <h2 class="au-details__title" id="au-details-title">{l s='The details' d='Modules.Hbkit.Shop'}</h2>
    <div class="au-details__body">
      {if $product.features}
        <dl class="au-details__specs">
          {foreach from=$product.features item=feature}
            <div class="au-details__spec"><dt>{$feature.name}</dt><dd>{$feature.value}</dd></div>
          {/foreach}
        </dl>
      {/if}
      {if $product.description}
        <div class="au-details__desc product__description rich-text">{$product.description nofilter}</div>
      {/if}
      <div class="product__accordion accordion accordion-flush" id="product_accordion">
        {if $modules.hbkit.size_guide}
          <div class="accordion-item" id="au_size">
            <h3 class="accordion-header" id="au_size_heading">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#au_size_collapse" aria-expanded="false" aria-controls="au_size_collapse">{l s='Ring size and resizing' d='Modules.Hbkit.Shop'}</button>
            </h3>
            <div id="au_size_collapse" class="accordion-collapse collapse" aria-labelledby="au_size_heading">
              <div class="accordion-body">{l s='Between two sizes, choose the larger one. We resize rings for free within 60 days.' d='Modules.Hbkit.Shop'}</div>
            </div>
          </div>
        {/if}
        <div class="accordion-item" id="au_care">
          <h3 class="accordion-header" id="au_care_heading">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#au_care_collapse" aria-expanded="false" aria-controls="au_care_collapse">{l s='Jewellery care' d='Modules.Hbkit.Shop'}</button>
          </h3>
          <div id="au_care_collapse" class="accordion-collapse collapse" aria-labelledby="au_care_heading">
            <div class="accordion-body">{l s='Soak in warm soapy water, brush gently and dry with a soft cloth. Free cleaning for life.' d='Modules.Hbkit.Shop'}</div>
          </div>
        </div>
        {capture name='au_reassurance'}{hook h='displayReassurance'}{/capture}
        {if $smarty.capture.au_reassurance|trim}
          <div class="accordion-item" id="au_delivery">
            <h3 class="accordion-header" id="au_delivery_heading">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#au_delivery_collapse" aria-expanded="false" aria-controls="au_delivery_collapse">{l s='Delivery and returns' d='Modules.Hbkit.Shop'}</button>
            </h3>
            <div id="au_delivery_collapse" class="accordion-collapse collapse" aria-labelledby="au_delivery_heading">
              <div class="accordion-body">{$smarty.capture.au_reassurance nofilter}</div>
            </div>
          </div>
        {/if}
        {foreach from=$product.extraContent item=extra key=extraKey}
          <div class="accordion-item" id="extra_{$extraKey}" {foreach $extra.attr as $key => $val} {$key}="{$val}"{/foreach}>
            <h3 class="accordion-header" id="product_extra_{$extraKey}_heading">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#product_extra_{$extraKey}_collapse" aria-expanded="false" aria-controls="product_extra_{$extraKey}_collapse">{$extra.title}</button>
            </h3>
            <div id="product_extra_{$extraKey}_collapse" class="accordion-collapse collapse" aria-labelledby="product_extra_{$extraKey}_heading">
              <div class="accordion-body">{$extra.content nofilter}</div>
            </div>
          </div>
        {/foreach}
      </div>
    </div>
  </section>
{/block}

{block name='hook_display_reassurance'}{/block}
