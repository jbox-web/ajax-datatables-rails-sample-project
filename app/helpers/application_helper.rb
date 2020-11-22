module ApplicationHelper

  DATATABLE_BUTTONS = {
    select_all: {
      label: 'datatables.buttons.select_all',
      icon: { name: 'check-square', opts: { icon_style: 'far' } },
      opts: { action: 'select_all', method: 'post' },
    },
    reset_selection: {
      label: 'datatables.buttons.reset_selection',
      icon: { name: 'square', opts: { icon_style: 'far' } },
      opts: { action: 'reset_selection', method: 'post' },
    },
    reset_filters: {
      label: 'datatables.buttons.reset_filters',
      icon: { name: 'sync-alt' },
      opts: { action: 'reset_filters' },
    },
    apply_default_filters: {
      label: 'datatables.buttons.apply_default_filters',
      icon: { name: 'filter' },
      opts: { action: 'apply_default_filters' },
    },
    csv: {
      label: 'datatables.buttons.csv',
      icon: { name: 'file-alt', opts: { icon_style: 'far' } },
      opts: { extend: 'csv' },
    },
    excel: {
      label: 'datatables.buttons.excel',
      icon: { name: 'file-excel', opts: { icon_style: 'far' } },
      opts: { extend: 'excel' },
    },
    pdf: {
      label: 'datatables.buttons.pdf',
      icon: { name: 'file-pdf', opts: { icon_style: 'far' } },
      opts: { extend: 'pdf' },
    },
    print: {
      label: 'datatables.buttons.print',
      icon: { name: 'print' },
      opts: { extend: 'print' },
    },
    columns: {
      label: 'datatables.buttons.columns',
      icon: { name: 'table' },
      opts: { extend: 'colvis', columns: '.colvis' },
    },
  }.freeze

  def datatable_button_for(button)
    button    = button.to_sym
    label     = DATATABLE_BUTTONS[button][:label]
    icon      = DATATABLE_BUTTONS[button][:icon][:name]
    icon_opts = DATATABLE_BUTTONS[button][:icon][:opts] || {}
    opts      = DATATABLE_BUTTONS[button][:opts]
    opts.merge(text: fa_icon(icon, icon_opts), titleAttr: t(label), button_name: button)
  end


  DATATABLE_LENGTH_MENU = [5, 10, 25, 50, 100].freeze

  def datatable_length_menu
    [DATATABLE_LENGTH_MENU, DATATABLE_LENGTH_MENU]
  end

end
