use Irssi;
use strict;
use FileHandle;

use vars qw($VERSION %IRSSI);

$VERSION = "0.0.4";
%IRSSI = (
    authors     => 'gregor herrmann <gregor+debian@comodo.priv.at>',
    name        => 'xscreensaver_away',
    description => 'set (un)away, if xscreensaver is (de)activated',
    license     => 'GPL v2',
    url         => 'http://info.comodo.priv.at/blog/articles/irssi_xscreensaver_away/',
);

# xscreensaver_away irssi module
#
# written by gregor herrmann <gregor+debian@comodo.priv.at>
#
# based on screen_away.pl, (C) 2004 Andreas 'ads' Scherbaum <ads@wars-nicht.de>,
# (released under the GPL v2)
#
#
# history:
#
# 0.0.4:
#   2007-01-24: add patch from Norbert Tretkowski - thanks!
#               * close filehandle IN
#
# 0.0.3:
#   2007-01-23: add patch from Norbert Tretkowski - thanks!
#               * activate even if xscreensaver is immediately locked after start
#               * now really use _window setting
#
# 0.0.2:
#   2006-04-03: fix error when xscreensaver has never been (de)activated
#
# 0.0.1:
#   2006-04-02: initial release, copied from screen_away.pl and adapted
#
#
# usage:
#
# put this script into your autorun directory and/or load it with
#  /SCRIPT LOAD xscreensaver_away.pl
#
# there are 5 settings available:
#
# /set xscreensaver_away_active ON/OFF/TOGGLE
# /set xscreensaver_away_repeat <integer>
# /set xscreensaver_away_message <string>
# /set xscreensaver_away_window <string>
# /set xscreensaver_away_nick <string>
#
# active means, that you will be only set away/unaway, if this
#   flag is set, default is ON
# repeat is the number of seconds, after the script will check the
#   screen status again, default is 5 seconds
# message is the away message sent to the server, default: not here ...
# window is a window number or name, if set, the script will switch
#   to this window, if it sets you away, default is '1'
# nick is the new nick, if the script goes away
#   will only be used it not empty


# variables
my $timer_name = undef;
my $away_status = 0;
my %old_nicks = ();
my %away = ();

# Register formats
Irssi::theme_register(
[
 'xscreensaver_away_crap', 
 '{line_start}{hilight ' . $IRSSI{'name'} . ':} $0'
]);

# if we are running
my $xscreensaver_away_used = 0;

# register config variables
Irssi::settings_add_bool('misc', $IRSSI{'name'} . '_active', 1);
Irssi::settings_add_int('misc', $IRSSI{'name'} . '_repeat', 60);
Irssi::settings_add_str('misc', $IRSSI{'name'} . '_message', "not here ...");
Irssi::settings_add_str('misc', $IRSSI{'name'} . '_window', "1");
Irssi::settings_add_str('misc', $IRSSI{'name'} . '_nick', "");

# init process
xscreensaver_away();

# xscreensaver_away()
#
# check, set or reset the away status
#
# parameter:
#   none
# return:
#   0 (OK)
sub xscreensaver_away {
  my $away;

  # only run if activated
  if (Irssi::settings_get_bool($IRSSI{'name'} . '_active') == 1) {
    if ($away_status == 0) {
      # display init message at first time
      Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'xscreensaver_away_crap',
        "activating $IRSSI{'name'} (interval: " . Irssi::settings_get_int($IRSSI{'name'} . '_repeat') . " seconds)");
    }
    
    # check last change of xscreensaver
    # cf. man xscreensaver-command
    open (IN, "unset DBUS_SESSION_BUS_ADDRESS; gnome-screensaver-command -q 2>/dev/null |");
    while (<IN>) {
      if (m/(The screensaver is active)/) {
        $away = 1;
      } elsif (m/(The screensaver is inactive)/) {
        $away = 2;
      }
    }
    close (IN);
    # check if status has changed
    if ($away == 1 and $away_status != 1) {
      # set away
      if (length(Irssi::settings_get_str($IRSSI{'name'} . '_window')) > 0) {
        # if length of window is greater then 0, make this window active
               Irssi::command('window goto ' . Irssi::settings_get_str($IRSSI{'name'} . '_window'));
      }
      Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'xscreensaver_away_crap',
        "Set away");
      my $message = Irssi::settings_get_str($IRSSI{'name'} . '_message');
      if (length($message) == 0) {
        # we have to set a message or we wouldnt go away
        $message = "not here ...";
      }
      my ($server);
      foreach $server (Irssi::servers()) {
        if (!$server->{usermode_away}) {
          # user isnt yet away
          $away{$server->{'chatnet'}} = 0;
          $server->command("AWAY -one $message") if (!$server->{usermode_away});
          if (length(Irssi::settings_get_str($IRSSI{'name'} . '_nick')) > 0) {
            # only change, if actual nick isnt already the away nick
            if (Irssi::settings_get_str($IRSSI{'name'} . '_nick') ne $server->{nick}) {
              # keep old nick
              $old_nicks{$server->{'chatnet'}} = $server->{nick};
              # set new nick
              $server->command("NICK " . Irssi::settings_get_str($IRSSI{'name'} . '_nick'));
            }
          }
        } else {
          # user is already away, remember this
          $away{$server->{'chatnet'}} = 1;
        }
      }
      $away_status = $away;
    } elsif ($away == 2 and $away_status != 2) {
      # unset away
      Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'xscreensaver_away_crap',
        "Reset away");
      my ($server);
      foreach $server (Irssi::servers()) {
        if ($away{$server->{'chatnet'}} == 1) {
          # user was already away, don't reset away
          $away{$server->{'chatnet'}} = 0;
          next;
        }
        $server->command('AWAY -one') if ($server->{usermode_away});
        if (defined($old_nicks{$server->{'chatnet'}}) and length($old_nicks{$server->{'chatnet'}}) > 0) {
          # set old nick
          $server->command("NICK " . $old_nicks{$server->{'chatnet'}});
          $old_nicks{$server->{'chatnet'}} = "";
        }
      }
      $away_status = $away;
    }
  }
  # but everytimes install a new timer
  register_xscreensaver_away_timer();
  return 0;
}

# register_xscreensaver_away_timer()
#
# remove old timer and install a new one
#
# parameter:
#   none
# return:
#   none
sub register_xscreensaver_away_timer {
  if (defined($timer_name)) {
    # remove old timer, if defined
    Irssi::timeout_remove($timer_name);
  }
  # add new timer with new timeout (maybe the timeout has been changed)
  $timer_name = Irssi::timeout_add(Irssi::settings_get_int($IRSSI{'name'} . '_repeat') * 1000, 'xscreensaver_away', '');
}

