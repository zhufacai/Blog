{# Website mata #}
{% include "./_head/meta.swig" %}

{# Website rss #}
{% if theme.rss === 'default' and config.feed and config.feed.path %}
  {{ feed_tag(config.feed.path) }}
{% elif theme.rss %}
  {{ feed_tag(theme.rss) }}
{% else %}
  {{ feed_tag('atom.xml') }}
{% endif %}

{# Website favicon #}
{% if theme.favicon %}
  <link rel="shortcut icon" type="image/x-icon" href="{{ url_for(theme.favicon) }}?v={{ theme.version }}" />
{% endif %}

{# Canonical, good for google search engine #}
<link rel="canonical" href="{{ config.url }}/{{ page.canonical_path.replace('index.html', '') }}"/>

{# Open Graph #}
{{ open_graph() }}

{# Theme styling #}
<link rel="stylesheet" type="text/css" href="{{ url_for('css/style.css') }}?v={{ theme.version }}" />
<link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet'>
{# Fancybox styling #}
{% if theme.theme.fancybox %}
  <link rel="stylesheet" type="text/css" href="{{ url_for('lib/fancybox/jquery.fancybox.css') }}" />
{% endif %}


{# Theme Configuration #}
{% include "../_script/config.swig" %}

{# Analytics #}
{% if not env.debug %}
  {% include "../_script/analytics.swig" %}
{% endif %}

{% if config.prettify.enable %}
  <link href="/plugins/prettify/{{ config.prettify.theme }}.css" rel="stylesheet">
{% endif %}
