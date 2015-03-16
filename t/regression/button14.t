###############################################################################
#
# Tests the output of Excel::Writer::XLSX against Excel generated files.
#
# reverse ('(c)'), November 2012, John McNamara, jmcnamara@cpan.org
#

use lib 't/lib';
use TestFunctions qw(_compare_xlsx_files _is_deep_diff);
use strict;
use warnings;

use Test::More tests => 1;

###############################################################################
#
# Tests setup.
#
my $filename     = 'button07.xlsm';
my $dir          = 't/regression/';
my $got_filename = $dir . "ewx_button14.xlsm";
my $exp_filename = $dir . 'xlsx_files/' . $filename;

my $ignore_members  = [];
my $ignore_elements = {};


###############################################################################
#
# Test the creation of a simple Excel::Writer::XLSX file.
#
use Excel::Writer::XLSX;

my $workbook  = Excel::Writer::XLSX->new( $got_filename );
my $worksheet = $workbook->add_worksheet();

# Implicit vba names.

$worksheet->insert_button(
    'C2',
    {
        macro   => 'say_hello',
        caption => 'Hello',
    }
);

$workbook->add_vba_project( $dir . 'xlsx_files/vbaProject02.bin' );


$workbook->close();


###############################################################################
#
# Compare the generated and existing Excel files.
#

my ( $got, $expected, $caption ) = _compare_xlsx_files(

    $got_filename,
    $exp_filename,
    $ignore_members,
    $ignore_elements,
);

_is_deep_diff( $got, $expected, $caption );


###############################################################################
#
# Cleanup.
#
unlink $got_filename;

__END__


