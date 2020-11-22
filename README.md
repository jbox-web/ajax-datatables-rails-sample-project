# ajax-datatables-rails sample project

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Install

```sh
nicolas$ git clone https://github.com/jbox-web/ajax-datatables-rails-sample-project.git
nicolas$ cd ajax-datatables-rails-sample-project
nicolas$ bin/bundle install
nicolas$ bin/yarn install
nicolas$ bin/rails db:migrate
nicolas$ bin/rails db:seed
nicolas$ bin/rails s
```

Open your web browser on http://127.0.0.1:3000. (On the first request Rails will trigger Webpack assets compilation so be patient.)

## Workflow

1. the [view](/app/views/posts/_datatable.html.haml) generate the HTML to render the datatable thanks to a [presenter](/app/presenters/data_table_presenter.rb) and a bunch of [helpers](/app/helpers/common/data_tables_helper.rb) methods. This HTML embeds datatable configuration in JSON format thanks to HTML5 data attributes.
2. [datatables-factory](https://github.com/jbox-web/datatables-factory) reads this JSON config to find and instantiate [this JS class](https://github.com/jbox-web/ajax-datatables-rails-sample-project/blob/master/app/frontend/assets/javascripts/my_app/datatables/posts_datatable.coffee). (loaded by [webpacker](https://github.com/jbox-web/ajax-datatables-rails-sample-project/blob/master/app/frontend/packs/application.coffee))
3. then it goes in the [router](/config/routes.rb)
4. then in the [controller](/app/controllers/posts_controller.rb)
5. then it the [datatable](/app/datatables/posts_datatable.rb)


This is the generated html :

```html
<table width="100%" class="table table-striped table-bordered display responsive no-wrap" id="posts-datatable" data-toggle="datatable" data-dtf-loader="">
  <thead>
    <tr>
      <th class="check_box"><input type="checkbox" name="posts-datatable-select_all" id="posts-datatable-select_all" value="1" title="Tout cocher/Tout décocher" /></th>
      <th class="name colvis">Name</th>
      <th class="title colvis">Title</th>
      <th class="rooms colvis">Rooms</th>
      <th class="enabled_s colvis">Enabled s</th>
      <th class="enabled_m colvis">Enabled m</th>
      <th class="created_at colvis">Created at</th>
      <th class="updated_at colvis">Updated at</th>
    </tr>
  </thead>
  <tbody class="context-menu"></tbody>
</table>
```

This is the generated json embeds in `data-dtf-loader` (the one above is empty for clarity) :

```json
{
  "dt_id": "#posts-datatable",
  "dt_class": "Datatables.PostsDatatable",
  "dt_options":
  {
    "language":
    {
      "processing": "Traitement en cours...",
      "search": "Rechercher\u0026nbsp;:",
      "lengthMenu": "Afficher _MENU_ éléments",
      "info": "Affichage de l&#39;élément _START_ à _END_ sur _TOTAL_ éléments",
      "infoEmpty": "Affichage de l&#39;élément 0 à 0 sur 0 éléments",
      "infoFiltered": "(filtré de _MAX_ éléments au total)",
      "infoPostFix": "",
      "loadingRecords": "Chargement en cours...",
      "zeroRecords": "Aucun élément à afficher",
      "emptyTable": "Aucune donnée disponible dans le tableau",
      "paginate":
      {
        "first": "Premier",
        "previous": "Précédent",
        "next": "Suivant",
        "last": "Dernier"
      },
      "aria":
      {
        "sortAscending": ": activer pour trier la colonne par ordre croissant",
        "sortDescending": ": activer pour trier la colonne par ordre décroissant"
      },
      "select":
      {
        "rows": "%d lignes sélectionnée(s)"
      },
      "buttons":
      {
        "pageLength":
        {
          "_": "Afficher %d éléments",
          "-1": "Montre tout"
        }
      }
    },
    "columns": [
    {
      "className": "check_box",
      "visible": true,
      "orderable": false,
      "searchable": false,
      "width": "",
      "data": "check_box",
      "name": "Select All"
    },
    {
      "className": "name colvis",
      "visible": true,
      "orderable": true,
      "searchable": true,
      "width": "",
      "data": "name",
      "name": "Name"
    },
    {
      "className": "title colvis",
      "visible": true,
      "orderable": true,
      "searchable": true,
      "width": "",
      "data": "title",
      "name": "Title"
    },
    {
      "className": "rooms colvis",
      "visible": true,
      "orderable": true,
      "searchable": true,
      "width": "",
      "data": "rooms",
      "name": "Rooms"
    },
    {
      "className": "enabled_s colvis",
      "visible": true,
      "orderable": true,
      "searchable": true,
      "width": "",
      "data": "enabled_s",
      "name": "Enabled s"
    },
    {
      "className": "enabled_m colvis",
      "visible": true,
      "orderable": true,
      "searchable": true,
      "width": "",
      "data": "enabled_m",
      "name": "Enabled m"
    },
    {
      "className": "created_at colvis",
      "visible": true,
      "orderable": true,
      "searchable": true,
      "width": "",
      "data": "created_at",
      "name": "Created at"
    },
    {
      "className": "updated_at colvis",
      "visible": true,
      "orderable": true,
      "searchable": true,
      "width": "",
      "data": "updated_at",
      "name": "Updated at"
    }],
    "buttons": [
    {
      "url": "/posts/select_all",
      "action": "select_all",
      "method": "post",
      "text": "\u003ci class=\"far fa-check-square\"\u003e\u003c/i\u003e",
      "titleAttr": "Tout sélectionner",
      "button_name": "select_all"
    },
    {
      "url": "/posts/reset_selection",
      "action": "reset_selection",
      "method": "post",
      "text": "\u003ci class=\"far fa-square\"\u003e\u003c/i\u003e",
      "titleAttr": "Réinitialiser la sélection",
      "button_name": "reset_selection"
    },
    {
      "action": "reset_filters",
      "text": "\u003ci class=\"fas fa-sync-alt\"\u003e\u003c/i\u003e",
      "titleAttr": "Réinitialiser tous les filtres",
      "button_name": "reset_filters"
    },
    {
      "action": "apply_default_filters",
      "text": "\u003ci class=\"fas fa-filter\"\u003e\u003c/i\u003e",
      "titleAttr": "Appliquer les filtres par défaut",
      "button_name": "apply_default_filters"
    },
    {
      "extend": "colvis",
      "columns": ".colvis",
      "text": "\u003ci class=\"fas fa-table\"\u003e\u003c/i\u003e",
      "titleAttr": "Visibilité des colonnes",
      "button_name": "columns"
    }],
    "filters": [
    {
      "filter_type": "select",
      "filter_plugin": "select2",
      "filter_plugin_options":
      {
        "minimumResultsForSearch": "-1"
      },
      "filter_container_id": "posts-enabled-s-filter",
      "filter_default_label": "Filtrer par statut",
      "column_id": 4
    },
    {
      "filter_type": "multi_select",
      "filter_plugin_options":
      {
        "width": "element",
        "minimumResultsForSearch": "-1"
      },
      "filter_plugin": "select2",
      "filter_container_id": "posts-enabled-m-filter",
      "filter_default_label": "Filtrer par statut",
      "column_id": 5
    },
    {
      "filter_type": "text",
      "filter_container_id": "posts-name-filter",
      "filter_default_label": "Filtrer par nom",
      "column_id": 1
    },
    {
      "filter_plugin": "jquery-ui",
      "filter_plugin_options":
      {
        "changeMonth": true,
        "changeYear": true,
        "dateFormat": "dd/mm/yy"
      },
      "filter_delay": 2000,
      "filter_type": "range_date",
      "filter_container_id": "posts-created-at-filter",
      "filter_default_label": ["date de début", "date de fin"],
      "column_id": 6
    },
    {
      "filter_plugin": "jquery-ui",
      "filter_plugin_options":
      {
        "changeMonth": true,
        "changeYear": true,
        "dateFormat": "dd/mm/yy"
      },
      "filter_delay": 2000,
      "filter_type": "range_date",
      "filter_container_id": "posts-updated-at-filter",
      "filter_default_label": ["date de début", "date de fin"],
      "column_id": 7
    },
    {
      "filter_delay": 1000,
      "filter_type": "range_number",
      "filter_container_id": "posts-rooms-filter",
      "filter_default_label": ["Min.", "Max."],
      "column_id": 3
    }],
    "filters_applied": [
    {
      "column_id": 4,
      "value": "1"
    },
    {
      "column_id": 5,
      "value": ["0", "1"]
    },
    {
      "column_id": 1,
      "value": "name 1"
    }],
    "source": "/posts/datatable.json",
    "dom": "\u003c\"html5buttons\"B\u003elr\u003c\"clearfix\"\u003e\u003c\"dataTables_info selected-count-wrapper \"\u003c\".selected-count\"\u003e\u003e\u003c\"\" i\u003etp",
    "select":
    {
      "style": "multi"
    },
    "order": [
      [2, "asc"]
    ]
  },
  "dtf_options":
  {
    "env": "development",
    "debug_log": true,
    "debug_dump": false,
    "context_menu": true
  }
}
```
