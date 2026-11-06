{**
 * Aurelle Jewels hero: Theme Kit's hero, with
 * - a second, outlined button on the first slide: its text is the section's small text and it goes to the ring sizer band;
 * - the product of the hero card (Theme Kit > Home page > Hero > Product on the card) as a small card on the photo:
 *   name, the card feature and the price.
 * The photo sits in an arch (custom.css). Other hero variants and slides are unchanged.
 * @author iamshoaibktk@gmail.com  @license AFL-3.0
 *}
<div class="hbk-hero hbk-hero--{$s.variant} hbk-hero--h-{$s.height} js-hbk-slider" data-autoplay="{$s.autoplay|intval}" style="--hbk-overlay:{($s.overlay|intval)/100}">
  <div class="hbk-hero__track">
    {foreach $section.items as $slide}
      <div class="hbk-hero__slide hbk-tone-{$slide.tone|default:'light'} hbk-align-{$slide.align|default:'left'}{if $slide@first} is-active{/if}" {if !$slide@first}aria-hidden="true"{/if}>
        {if !empty($slide.image_url)}
          <figure class="hbk-hero__media au-hero__media">
            <picture>
              {if !empty($slide.image_mobile_url)}<source media="(max-width: 767px)" srcset="{$slide.image_mobile_url}">{/if}
              <img src="{$slide.image_url}" alt="{$slide.title|escape:'html':'UTF-8'}" {if $slide.image_w}width="{$slide.image_w}" height="{$slide.image_h}"{/if} {if $slide@first}fetchpriority="high"{else}loading="lazy"{/if}>
            </picture>
            {if $slide@first && !empty($section.card.product)}{assign var=card value=$section.card}
              <figcaption class="au-hero__card">
                <a class="au-hero__name" href="{$card.product.url}">{$card.product.name}</a>
                <span class="au-hero__meta">{if $card.tag}{$card.tag} · {/if}{$card.product.price}</span>
              </figcaption>
            {/if}
          </figure>
        {/if}
        <div class="hbk-hero__content">
          <div class="hbk-hero__box">
            {if $slide.subtitle}<p class="hbk-eyebrow">{$slide.subtitle}</p>{/if}
            {if $slide.title}{if $slide@first}<h2 class="hbk-hero__title">{$slide.title}</h2>{else}<p class="hbk-hero__title">{$slide.title}</p>{/if}{/if}
            {if $slide.text}<div class="hbk-hero__text">{$slide.text nofilter}</div>{/if}
            {if ($slide.button && $slide.href) || ($slide@first && $section.subtitle)}
              <div class="au-hero__btns">
                {if $slide.button && $slide.href}<a class="btn btn-primary hbk-btn" href="{$slide.href}">{$slide.button}</a>{/if}
                {if $slide@first && $section.subtitle}<a class="btn btn-outline-primary hbk-btn" href="#au-sizer">{$section.subtitle}</a>{/if}
              </div>
            {/if}
          </div>
        </div>
      </div>
    {/foreach}
  </div>
  {if $section.items|count > 1}
    <button type="button" class="hbk-hero__nav hbk-hero__nav--prev js-hbk-prev" aria-label="{l s='Previous slide' d='Modules.Hbkit.Shop'}"><span class="material-icons" aria-hidden="true">chevron_left</span></button>
    <button type="button" class="hbk-hero__nav hbk-hero__nav--next js-hbk-next" aria-label="{l s='Next slide' d='Modules.Hbkit.Shop'}"><span class="material-icons" aria-hidden="true">chevron_right</span></button>
    <div class="hbk-hero__dots">
      {foreach $section.items as $slide}<button type="button" class="js-hbk-dot{if $slide@first} is-active{/if}" aria-label="{l s='Go to slide %d' sprintf=[$slide@iteration] d='Modules.Hbkit.Shop'}"></button>{/foreach}
    </div>
  {/if}
</div>
