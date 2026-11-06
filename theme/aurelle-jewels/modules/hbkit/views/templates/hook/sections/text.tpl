{**
 * Aurelle Jewels: a text section with the style name "au-sizer" becomes the ring sizer band. The title, text and link
 * (with the section's small text as its label) come from the section; the theme adds the size buttons and the circle,
 * drawn at the true inner diameter of the size (custom.js). Every other text section uses Theme Kit's own template.
 * @author iamshoaibktk@gmail.com  @license AFL-3.0
 *}
{if $s.css|default:'' == 'au-sizer'}
  <div class="au-band" id="au-sizer">
    <div class="au-band__body">
      <p class="hbk-eyebrow">{l s='The ring sizer' d='Modules.Hbkit.Shop'}</p>
      {if $section.title}<h2 class="hbk-title">{$section.title}</h2>{/if}
      {if $section.content}<div class="au-band__text">{$section.content nofilter}</div>{/if}
      {if $section.href && $section.subtitle}<a class="au-band__link" href="{$section.href}">{$section.subtitle}</a>{/if}
    </div>
    <div class="au-sizer js-au-sizer" data-sizes="48,50,52,54,56,58" data-size="52">
      <div class="au-sizer__stage" aria-hidden="true"><span class="au-sizer__ring js-au-ring"></span><span class="au-sizer__mm js-au-mm"></span></div>
      <div class="au-sizer__side">
        <span class="au-sizer__label" id="au-sizer-label">{l s='Size' d='Modules.Hbkit.Shop'}</span>
        <div class="au-sizer__sizes js-au-sizes" role="radiogroup" aria-labelledby="au-sizer-label"></div>
        <dl class="au-sizer__facts">
          <dt>{l s='Inside' d='Modules.Hbkit.Shop'}</dt><dd class="js-au-mm"></dd>
          <dt>UK</dt><dd class="js-au-uk"></dd>
          <dt>US</dt><dd class="js-au-us"></dd>
        </dl>
      </div>
    </div>
  </div>
{else}
  {include file="{$smarty.const._PS_MODULE_DIR_}hbkit/views/templates/hook/sections/text.tpl"}
{/if}
