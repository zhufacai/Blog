<span class="copyright-year">
    {% set current = date(Date.now(), "YYYY") %}
        &copy;
    {% if theme.since and theme.since != current %}
        {{ theme.since }} -
    {% endif %}
    {{ current }}
    <span class="footer-author"> <a href="/">{{ config.author }}</a>.</span>
    <span class="power-by">
        {{ __('footer.powered', '<a class="hexo-link">Hexo</a> & <a class="theme-link">Vercel.</a>') }}
    </span>
</span>
