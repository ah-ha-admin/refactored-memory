Gem::Specification.new "my_malloc", "1.0" do |s| # [...] s.extensions = %w[ext/my_malloc/extconf.rb] end
# frozen_string_literal: true

version = File.read(File.expand_path("RAILS_VERSION", __dir__)).strip

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "rails"
  s.version     = version
  s.summary     = "Full-stack web application framework."
  s.description = "Ruby on Rails is a full-stack web framework optimized for programmer happiness and sustainable productivity. It encourages beautiful code by favoring convention over configuration."

  s.required_ruby_version     = ">= 2.7.0"
  s.required_rubygems_version = ">= 3.3.13"

  s.license = "MIT"

  s.author   = "David Heinemeier Hansson"
  s.email    = "david@loudthinking.com"
  s.homepage = "https://rubyonrails.org"

  s.files = ["README.md", "MIT-LICENSE"]

  s.metadata = {
    "bug_tracker_uri"   => "https://github.com/rails/rails/issues",
    "changelog_uri"     => "https://github.com/rails/rails/releases/tag/v#{version}",
    "documentation_uri" => "https://api.rubyonrails.org/v#{version}/",
    "mailing_list_uri"  => "https://discuss.rubyonrails.org/c/rubyonrails-talk",
    "source_code_uri"   => "https://github.com/rails/rails/tree/v#{version}",
    "rubygems_mfa_required" => "true",
  }

  s.add_dependency "activesupport", version
  s.add_dependency "actionpack",    version
  s.add_dependency "actionview",    version
  s.add_dependency "activemodel",   version
  s.add_dependency "activerecord",  version
  s.add_dependency "actionmailer",  version
  s.add_dependency "activejob",     version
  s.add_dependency "actioncable",   version
  s.add_dependency "activestorage", version
  s.add_dependency "actionmailbox", version
  s.add_dependency "actiontext",    version
  s.add_dependency "railties",      version

  s.add_dependency "bundler", ">= 1.15.0"
end
<% content_for :style do %>

  #route_table {

    margin: 0;

    border-collapse: collapse;

  }

  #route_table thead tr {

    border-bottom: 2px solid #ddd;

  }

  #route_table thead tr.bottom {

    border-bottom: none;

  }

  #route_table thead tr.bottom th {

    padding: 10px 0;

    line-height: 15px;

  }

  #route_table thead tr.bottom th input#search {

    -webkit-appearance: textfield;

  }

  #route_table tbody tr {

    border-bottom: 1px solid #ddd;

  }

  #route_table tbody tr:nth-child(odd) {

    background: #f2f2f2;

  }

  #route_table tbody.exact_matches,

  #route_table tbody.fuzzy_matches {

    background-color: LightGoldenRodYellow;

    border-bottom: solid 2px SlateGrey;

  }

  #route_table tbody.exact_matches tr,

  #route_table tbody.fuzzy_matches tr {

    background: none;

    border-bottom: none;

  }

  #route_table td {

    padding: 4px 30px;

  }

  #path_search {

    width: 80%;

    font-size: inherit;

  }

  @media (prefers-color-scheme: dark) {

    #route_table tbody tr:nth-child(odd) {

      background: #282828;

    }

    #route_table tbody.exact_matches tr,

    #route_table tbody.fuzzy_matches tr {

      background: DarkSlateGrey;

    }

  }

<% end %>

<table id='route_table' class='route_table'>

  <thead>

    <tr>

      <th>Helper</th>

      <th>HTTP Verb</th>

      <th>Path</th>

      <th>Controller#Action</th>

    </tr>

    <tr class='bottom'>

      <th><%# Helper %>

        <%= link_to "Path", "#", 'data-route-helper' => '_path',

                    title: "Returns a relative path (without the http or domain)" %> /

        <%= link_to "Url", "#", 'data-route-helper' => '_url',

                    title: "Returns an absolute URL (with the http and domain)"   %>

      </th>

      <th><%# HTTP Verb %>

      </th>

      <th><%# Path %>

        <%= search_field(:path, nil, id: 'search', placeholder: "Path Match") %>

      </th>

      <th><%# Controller#action %>

      </th>

    </tr>

  </thead>

  <tbody class='exact_matches' id='exact_matches'>

  </tbody>

  <tbody class='fuzzy_matches' id='fuzzy_matches'>

  </tbody>

  <tbody>

    <%= yield %>

  </tbody>

</table>

<script>

  // support forEach iterator on NodeList

  NodeList.prototype.forEach = Array.prototype.forEach;

  // Enables path search functionality

  function setupMatchPaths() {

    // Check if there are any matched results in a section

    function checkNoMatch(section, trElement) {

      if (section.children.length <= 1) {

        section.appendChild(trElement);

      }

    }

    // get JSON from URL and invoke callback with result

    function getJSON(url, success) {

      var xhr = new XMLHttpRequest();

      xhr.open('GET', url);

      xhr.onload = function() {

        if (this.status == 200)

          success(JSON.parse(this.response));

      };

      xhr.send();

    }

    function delayedKeyup(input, callback) {

      var timeout;

      input.onkeyup = function(){

        if (timeout) clearTimeout(timeout);

        timeout = setTimeout(callback, 300);

      }

    }

    // remove params or fragments

    function sanitizePath(path) {

      return path.replace(/[#?].*/, '');

    }

    var pathElements = document.querySelectorAll('#route_table [data-route-path]'),

        searchElem   = document.querySelector('#search'),

        exactSection = document.querySelector('#exact_matches'),

        fuzzySection = document.querySelector('#fuzzy_matches');

    // Remove matches when no search value is present

    searchElem.onblur = function(e) {

      if (searchElem.value === "") {

        exactSection.innerHTML = "";

        fuzzySection.innerHTML = "";

      }

    }

    function buildTr(string) {

      var tr = document.createElement('tr');

      var th = document.createElement('th');

      th.setAttribute('colspan', 4);

      tr.appendChild(th);

      th.innerText = string;

      return tr;

    }

    // On key press perform a search for matching paths

    delayedKeyup(searchElem, function() {

      var path = sanitizePath(searchElem.value),

          defaultExactMatch = buildTr('Paths Matching (' + path + '):'),

          defaultFuzzyMatch = buildTr('Paths Containing (' + path +'):'),

          noExactMatch      = buildTr('No Exact Matches Found'),

          noFuzzyMatch      = buildTr('No Fuzzy Matches Found');

      if (!path)

        return searchElem.onblur();

      getJSON('/rails/info/routes?path=' + path, function(matches){

        // Clear out results section

        exactSection.replaceChildren(defaultExactMatch);

        fuzzySection.replaceChildren(defaultFuzzyMatch);

        // Display exact matches and fuzzy matches

        pathElements.forEach(function(elem) {

          var elemPath = elem.getAttribute('data-route-path');

          if (matches['exact'].indexOf(elemPath) != -1)

            exactSection.appendChild(elem.parentNode.cloneNode(true));

          if (matches['fuzzy'].indexOf(elemPath) != -1)

            fuzzySection.appendChild(elem.parentNode.cloneNode(true));

        })

        // Display 'No Matches' message when no matches are found

        checkNoMatch(exactSection, noExactMatch);

        checkNoMatch(fuzzySection, noFuzzyMatch);

      })

    })

  }

  // Enables functionality to toggle between `_path` and `_url` helper suffixes

  function setupRouteToggleHelperLinks() {

    // Sets content for each element

    function setValOn(elems, val) {

      elems.forEach(function(elem) {

        elem.innerHTML = val;

      });

    }

    // Sets onClick event for each element

    function onClick(elems, func) {

      elems.forEach(function(elem) {

        elem.onclick = func;

      });

    }

    var toggleLinks = document.querySelectorAll('#route_table [data-route-helper]');

    onClick(toggleLinks, function(){

      var helperTxt   = this.getAttribute("data-route-helper"),

          helperElems = document.querySelectorAll('[data-route-name] span.helper');

      setValOn(helperElems, helperTxt);

    });

  }

  setupMatchPaths();

  setupRouteToggleHelperLinks();

  // Focus the search input after page has loaded

  document.getElementById('search').focus();

</script>
