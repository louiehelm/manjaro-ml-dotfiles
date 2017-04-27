source .cache/wal/colors.sh

echo 'style "default"
{
#  engine "hcengine" {
#    edge_thickness = 2
#  }

  xthickness = 2
  ythickness = 2

  EelEditableLabel::cursor_aspect_ratio = 0.1
  EelEditableLabel::cursor_color    = "'$color13'"

  GtkEntry::cursor_color    = "'$color13'"
  GtkEntry::cursor_aspect_ratio = 0.1

  GtkHSV::focus-line-pattern = "\0"

  GtkRange::stepper-size = 20

  GtkTextView::cursor_aspect_ratio = 0.1
  GtkTextView::cursor_color    = "'$color13'"

  GtkTreeView::expander-size = 16

  GtkWidget::focus-line-pattern = "\4\2"
  GtkWidget::focus-line-width = 2
  GtkWidget::focus-padding = 0
  GtkWidget::interior_focus = 1
  GtkWidget::link-color = "'$color13'"
  GtkWidget::visited-link-color = "'$color14'"

  fg[NORMAL]      = "'$color0'"  # where is it ??
  text[NORMAL]    = "'$color0'"  # URL / interface text
#  bg[NORMAL]      = "'$color14'"  # tabs / should be 
#  base[NORMAL]    = "'$color15'"  # url bar color

  fg[INSENSITIVE]      = "'$color4'"  # URL bar back
  bg[INSENSITIVE]      = "'$color1'" # top bar off chrome (BEST COLOR)
  text[INSENSITIVE]    = "'$color0'"
  base[INSENSITIVE]    = "'$color1'"

  fg[PRELIGHT]    = "'$color0'"
  text[PRELIGHT]  = "'$color0'"
  bg[PRELIGHT]    = "'$color1'"
  base[PRELIGHT]  = "'$color4'"

  fg[ACTIVE]      = "'$color5'"
  text[ACTIVE]    = "'$color0'"
  bg[ACTIVE]      = "'$color1'"
  base[ACTIVE]    = "'$color2'"

  fg[SELECTED]    = "'$color0'"
  text[SELECTED]  = "'$color0'"
  bg[SELECTED]    = "'$color1'"
  base[SELECTED]  = "'$color7'"
}

class "GtkWidget" style "default"

# widget "*PanelWidget*" style "panel"
# widget "*PanelApplet*" style "panel"
# class "*Panel*" style "panel"
# widget_class "*Applet*" style "panel"
# class "*notif*" style "panel"
# class "*Notif*" style "panel"
# class "*Tray*" style "panel"
# class "*tray*" style "panel"
'

# Reload GTK theme
type -p python2 >/dev/null 2>&1 || return

python2 - <<END
import sys, gtk

events=gtk.gdk.Event(gtk.gdk.CLIENT_EVENT)
data=gtk.gdk.atom_intern("_GTK_READ_RCFILES", False)
events.data_format=8
events.send_event=True
events.message_type=data
events.send_clientmessage_toall()
END
