# Load jQuery
import $ from 'jquery'

# Load jQuery datepicker for Datatables
require 'jquery-ui/ui/widgets/datepicker'
require 'jquery-ui/ui/i18n/datepicker-fr'

# Load Popper
require 'popper.js'

# Load Bootstrap
require 'bootstrap'

# Load Rails UJS
import Rails from '@rails/ujs'
Rails.start()

# Load Turbo(links)
import "@hotwired/turbo-rails"

# Load Select2
require 'select2/dist/js/select2.full.js'

# Load Datatables
require('datatables.net-bs4')(window, $)
require('datatables.net-buttons-bs4')(window, $)
require('datatables.net-buttons/js/buttons.colVis.js')(window, $)
require('datatables.net-buttons/js/buttons.html5.js')(window, $)
require('datatables.net-buttons/js/buttons.print.js')(window, $)
require('datatables.net-responsive-bs4')(window, $)
require('datatables.net-select-bs4')(window, $)

$.extend $.fn.dataTable.defaults,
  processing: true
  serverSide: true
  stateSave:  true
  responsive: true
  pageLength: 10
  lengthMenu: [[10, 25, 50, 100, 200, 500], [10, 25, 50, 100, 200, 500]]
  pagingType: 'simple_numbers'
  dom:        'lfrtip'
  order:      []

# Load DatatablesFactory
import { DatatableBase } from '@jbox-web/datatables-factory'

# Close context_menu when click outside
$(document).on('click', DatatableBase.clean_context_menu)

# Load datatables
$(document).on('turbo:load', DatatableBase.load_datatables)

# Load application JS
import { MyApp, Datatables } from 'my_app/index.coffee'
window.MyApp = MyApp
window.Datatables = Datatables

# Load CSS
import 'styles/application.scss'
