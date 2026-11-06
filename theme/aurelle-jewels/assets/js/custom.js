/**
 * Aurelle Jewels: the ring sizer.
 * - Home page band (sections/text.tpl, style name "au-sizer"): size buttons and a circle at the true inner diameter.
 * - Product pages with ring sizes: "Find your size" beside the sizes opens the same circle for the chosen size.
 * A ring size is its inner circumference in millimetres, so the diameter is size / π. CSS millimetres are close to real
 * ones on most screens; the panel says it is approximate.
 * @author iamshoaibktk@gmail.com  @license AFL-3.0
 */
(function () {
  var F = window.hbkitFront || {};
  // UK and US equivalents of the sizes on the ring size guide.
  var CONV = { 48: ['I½', '4½'], 50: ['K½', '5½'], 52: ['L½', '6'], 54: ['N', '7'], 56: ['P', '7½'], 58: ['Q½', '8½'] };

  function setText(root, sel, text) {
    root.querySelectorAll(sel).forEach(function (el) { if (el.textContent !== text) el.textContent = text; });
  }

  function draw(box, size) {
    var n = parseFloat(size);
    if (!n) return;
    var d = n / Math.PI;
    var ring = box.querySelector('.js-au-ring');
    if (ring) { ring.style.width = d.toFixed(2) + 'mm'; ring.style.height = d.toFixed(2) + 'mm'; }
    var mm;
    try { mm = d.toLocaleString(document.documentElement.lang || undefined, { minimumFractionDigits: 1, maximumFractionDigits: 1 }); } catch (e) { mm = d.toFixed(1); }
    mm += ' mm';
    setText(box, '.js-au-mm', mm);
    var c = CONV[Math.round(n)] || ['–', '–'];
    setText(box, '.js-au-uk', c[0]);
    setText(box, '.js-au-us', c[1]);
    box.querySelectorAll('.js-au-uk-us').forEach(function (el) {
      var t = (el.getAttribute('data-format') || '').replace('[1]', String(n)).replace('[2]', c[0]).replace('[3]', c[1]);
      if (el.textContent !== t) el.textContent = t;
    });
  }

  // Home page band
  function band(box) {
    if (box.dataset.auReady) return;
    box.dataset.auReady = '1';
    var list = box.querySelector('.js-au-sizes');
    var sizes = (box.getAttribute('data-sizes') || '').split(',');
    var current = box.getAttribute('data-size') || sizes[0];
    sizes.forEach(function (s) {
      var b = document.createElement('button');
      b.type = 'button';
      b.className = 'au-size';
      b.setAttribute('role', 'radio');
      b.textContent = s;
      b.addEventListener('click', function () { pick(s); });
      list.appendChild(b);
    });
    function pick(s) {
      current = s;
      list.querySelectorAll('.au-size').forEach(function (b) { b.setAttribute('aria-checked', b.textContent === s ? 'true' : 'false'); b.tabIndex = b.textContent === s ? 0 : -1; });
      draw(box, s);
    }
    list.addEventListener('keydown', function (e) {
      if (['ArrowRight', 'ArrowDown', 'ArrowLeft', 'ArrowUp'].indexOf(e.key) < 0) return;
      e.preventDefault();
      var i = sizes.indexOf(current) + (e.key === 'ArrowRight' || e.key === 'ArrowDown' ? 1 : -1);
      if (i < 0 || i >= sizes.length) return;
      pick(sizes[i]);
      list.querySelectorAll('.au-size')[i].focus();
    });
    pick(current);
  }

  // Product page: the size group is the Theme Kit quick filter group (F.size_name) with numeric values.
  var open = false;
  function sizeGroup(scope) {
    var found = null;
    scope.querySelectorAll('.product-variant').forEach(function (v) {
      var lg = v.querySelector('.product-variant__legend');
      var labels = [].slice.call(v.querySelectorAll('.btn-check + label, .btn-check + .btn'));
      var numeric = labels.length && labels.every(function (l) { var n = sizeOf(l); return n >= 40 && n <= 75; });
      if (!found && numeric && (!F.size_name || (lg && lg.textContent.trim() === F.size_name))) found = v;
    });
    return found;
  }
  // A size label reads "Size - 52" (the group name is there for screen readers): take the number at the end.
  function sizeOf(label) {
    var m = (label.textContent || '').trim().match(/(\d+(?:[.,]\d+)?)$/);
    return m ? parseFloat(m[1].replace(',', '.')) : NaN;
  }
  function chosen(group) {
    var input = group.querySelector('.btn-check:checked');
    var label = input && group.querySelector('label[for="' + input.id + '"]');
    return label ? String(sizeOf(label) || '') : '';
  }
  // "Colour : Silver" from PrestaShop becomes "Colour: Silver".
  function tidyLabels() {
    document.querySelectorAll('.product-variant__selected').forEach(function (el) {
      var t = el.textContent.replace(/^\s*:\s*/, ': ').replace(/\s+$/, '');
      if (el.textContent !== t) el.textContent = t;
    });
  }
  function product() {
    var tpl = document.getElementById('au-sizer-tpl');
    var scope = document.querySelector('.js-product-container, .product-container');
    if (!tpl || !scope) return;
    var group = sizeGroup(scope);
    var acc = document.getElementById('au_size');
    if (!group) { if (acc) acc.remove(); return; }
    if (!group.querySelector('.js-au-find')) {
      var frag = tpl.content.cloneNode(true);
      var btn = frag.querySelector('.js-au-find');
      var panel = frag.querySelector('.js-au-sizer');
      var legend = group.querySelector('.product-variant__legend');
      btn.addEventListener('click', function () {
        open = !open;
        panel.hidden = !open;
        btn.setAttribute('aria-expanded', open ? 'true' : 'false');
      });
      panel.hidden = !open;
      btn.setAttribute('aria-expanded', open ? 'true' : 'false');
      if (legend) legend.insertAdjacentElement('afterend', btn); else group.prepend(btn);
      group.appendChild(panel);
    }
    var panelEl = group.querySelector('.js-au-sizer');
    var s = chosen(group);
    if (panelEl && s) draw(panelEl, s);
  }

  // Category pages: the ring size buttons show only when the category has sizes.
  function sizeBar() {
    var bar = document.querySelector('.js-au-sizes');
    if (!bar) return;
    var box = bar.querySelector('.js-hbk-chips');
    var has = box && box.querySelectorAll('.hbk-chip').length > 0;
    if (bar.hidden === has) bar.hidden = !has;
    var label = bar.querySelector('.js-au-sizes-label');
    var text = box ? (box.getAttribute('aria-label') || '') : '';
    if (label && label.textContent !== text) label.textContent = text;
  }

  var queued = false;
  function run() {
    queued = false;
    sizeBar();
    tidyLabels();
    document.querySelectorAll('.au-band .js-au-sizer').forEach(band);
    product();
  }
  function queue() { if (!queued) { queued = true; window.requestAnimationFrame(run); } }
  document.addEventListener('change', function (e) {
    if (e.target.classList && e.target.classList.contains('btn-check')) queue();
  });
  function init() {
    run();
    new MutationObserver(queue).observe(document.body, { childList: true, subtree: true });
  }
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init); else init();
})();
