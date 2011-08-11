use strict;
use vars qw($VERSION %IRSSI);

use Irssi;

$VERSION = '1.01';

%IRSSI = (
    authors     => 'Alexandre Gauthier',
    contact     => 'alex@underwares.org',
    name        => 'Bullshit Knifaisms Smileys',
    description => 'This script pretty much allows you spam ' .
                   'horrible japanese smileys. Use at your own ' .
                   'risk.',
    license     => 'Public Domain',
);


#### FIXME: OH LAWD HARCODED CONTENTS ####

my %EMOJIS = (
    ':hug:'          => 'ヽ(´ー｀)ノ',
    ':yudothis:'     => 'щ(ﾟДﾟщ)',
    ':xd:'           => '( ˃ ヮ˂)',
    ':kiss:'         => '( ¯3¯)',
    ':smile:'        => '( ﾟ ヮﾟ)',
    ':mad3:'         => 'ಠ_ಠ',
    ':mad2:'         => 'ヽ(`Д´)ﾉ',
    ':punch:'        => '(　`Д´)=◯)`ν°)',
    ':shock2:'       => '(゜△゜;)',
    ':sigh2:'        => '(　´Д｀)',
    ':table3:'       => '(ﾉ `Д´)ﾉ ~~~┻━┻)`ν゜)',
    ':table2:'       => '(　`Д´)ﾉ┳━┳',
    ':moe:'          => 'ℳℴℯ❤',
    ':cry:'          => '｡･ﾟ･(ﾉД｀)･ﾟ･｡',
    ':nyoro:'        => '(´・ω・)',
    ':cummed:'       => 'ＴＨＥ　ＰＬＥＡＳＵＲＥ　ＯＦ　ＢＥＩＮＧ　ＣＵＭＭＥＤ　ＩＮＳＩＤＥ',
    ':mad:'          => '(╬ ಠ益ಠ)',
    ':yay:'          => "ヽ(' ▽' )ノ !",
    ':flower5:'      => '♡(✿ˇ◡ˇ)人(ˇ◡ˇ✿)♡',
    ':claw:'         => '( ﾟ◡◡ﾟ)☄',
    ':facethrow:'    => '(ﾉ ¯3¯)ﾉ ~( `Д´)',
    ':haha:'         => '( ﾟ∀ﾟ)ｱﾊﾊ八八ﾉヽﾉヽﾉヽﾉ ＼ / ＼/ ＼',
    ':cummedhorror:' => 'ＴＨＥ ＨＯＲＲＯＲ ＯＦ ＢＥＩＮＧ ＣＵＭＭＥＤ ＩＮＳＩＤＥ.',
    ':snob:'         => '(¯^¯ )',
    ':idunnolol:'    => '¯\(°_o)/¯',
    ':table:'        => '(ﾉ `Д´)ﾉ ~┻━┻',
    ':hug4:'         => '(づ｡◕‿◕｡)づ',
    ':hug3:'         => '(づ｡◕‿‿‿‿◕｡)づ',
    ':smile2:'       => '(｡◕‿◕｡)',
    ':sad:'          => '( ﾟ∩ﾟ)',
    ':hug2:'         => '(っ´ω｀)っ',
    ':shock:'        => 'Σ(ﾟДﾟ)',
    ':sigh:'         => '( ´_ゝ`)',
    ':slap:'         => '(　`Д´)ﾉ)`ν゜)',
    ':codeindentation:'     => 'ＴＨＥ ＦＯＲＣＥＤ ＩＮＤＥＮＴＡＴＩＯＮ ＯＦ ＣＯＤＥ.',
    ':corea:'       => '（　｀ー´）',
    
);

my $locked = 0;

sub knifaize {
    my $enabled = Irssi::settings_get_bool('enable_knifamode');

    unless ($enabled && !$locked) {
        return;
    }

    my $signal = Irssi::signal_get_emitted();
    my ($data, $server, $witem) = @_;

    # Do not filter commands
    if ($data =~ /^\//) { return };

    while ( my($trigger, $emoji) = each(%EMOJIS)) {
        $data =~ s/$trigger/$emoji/g;
    }
    
    # event with shit mutex, lawl
    $locked = 1;
    Irssi::signal_emit("$signal", $data, $server, $witem);
    Irssi::signal_stop();
    $locked = 0;
}

sub emojitable {
    my ($data, $server, $witem) = @_;
    return unless $witem;
}

# Settings
Irssi::settings_add_bool('lookandfeel', 'enable_knifamode', 1);

# hooks
Irssi::signal_add_first('send command', 'knifaize');

# commands
# TODO: halp

Irssi::print("Knifa mode support version $VERSION initialized");
Irssi::print("Loaded " . keys(%EMOJIS) . " knifaisms.");



