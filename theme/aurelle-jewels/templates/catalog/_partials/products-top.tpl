{**
 * Aurelle Jewels: listing toolbar between two hairlines. The ring sizes (Theme Kit quick filter buttons, shown only when
 * the category has sizes, custom.js) with "Find your size" to the ring size guide, then the count, Filter and the sort.
 * @author iamshoaibktk@gmail.com  @license AFL-3.0
 *}
<div id="js-product-list-top">
  <div class="products__selection hbk-toolbar">
    {if !empty($listing.rendered_facets)}
      <div class="au-sizes js-au-sizes" hidden>
        <span class="au-sizes__label js-au-sizes-label"></span>
        <div class="hbk-chips js-hbk-chips" role="group"></div>
        {if !empty($modules.hbkit.size_guide)}<a class="au-sizes__guide" href="{$modules.hbkit.size_guide.url}">{l s='Find your size' d='Modules.Hbkit.Shop'}</a>{/if}
      </div>
    {/if}
    <span class="hbk-toolbar__count">
      {l s='%count% products' sprintf=['%count%' => $listing.pagination.total_items] d='Modules.Hbkit.Shop'}
    </span>
    {if !empty($listing.rendered_facets)}
      <button id="search_filter_toggler" class="hbk-toolbar__filter js-search-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvas-faceted" aria-controls="offcanvas-faceted">
        <svg width="16" height="12" viewBox="0 0 16 12" aria-hidden="true" focusable="false"><path d="M0 2h16M3 6h10M6 10h4" stroke="currentColor" stroke-width="1.4" fill="none"/></svg>
        {l s='Filter' d='Modules.Hbkit.Shop'}
      </button>
    {/if}
    <div class="products__sort">
      {block name='sort_by'}
        {include file='catalog/_partials/sort-orders.tpl' sort_orders=$listing.sort_orders}
      {/block}
    </div>
  </div>
</div>
