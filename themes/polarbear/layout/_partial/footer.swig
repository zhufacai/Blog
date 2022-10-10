<span class="copyright-year">
    {% set current = date(Date.now(), "YYYY") %}
        &copy;
    {% if theme.since and theme.since != current %}
        {{ theme.since }} -
    {% endif %}
    {{ current }}
    <span class="footer-author" href="https://www.joker.cc/">{{ config.author }}.</span>
    <span class="power-by">
        {{ __('footer.powered', '<a class="hexo-link">Hexo</a> & <a class="theme-link">Vercel.</a>') }}
    </span>
</span>
