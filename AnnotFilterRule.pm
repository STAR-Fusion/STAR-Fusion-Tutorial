package AnnotFilterRule;

## This is a boilerplate for AnnotFilterRule
##   which should implement rules for filtering CTAT Fusion predictions on a per-result (row) basis
##   ideally based on the annotation field, but can be customized to liking.

use strict;
use warnings;


####
sub examine_fusion_prediction {
    my ($fusion_result_row) = @_;

    #
    #  $fusion_result_row has format:
    #
    # {
    #    'LeftBreakpoint' => 'chr17:57161363:-',
    #    'LeftGene' => 'TRIM37^ENSG00000108395.9',
    #    'SpanningFragCount' => '3',
    #    'SpanningFrags' => 'HWI-EAS418:3:83:910:1531,HWI-EAS418:6:2:1243:1560,HWI-EAS418:6:21:1070:1329',
    #    'RightGene' => 'MYO19^ENSG00000141140.12',
    #    'FFPM' => '795.8615',
    #    'JunctionReadCount' => '1',
    #    '#FusionName' => 'TRIM37--MYO19',
    #    'annots' => '["CCLE","Klijn_CellLines","INTRACHROMOSOMAL[chr17:22.16Mb]"]',
    #    'LeftBreakDinuc' => 'GT',
    #    'LargeAnchorSupport' => 'NO_LDAS',
    #    'JunctionReads' => 'HWI-EAS418:6:85:1228:1056',
    #    'RightBreakDinuc' => 'AG',
    #    'RightBreakEntropy' => '1.7819',
    #    'SpliceType' => 'ONLY_REF_SPLICE',
    #    'RightBreakpoint' => 'chr17:34863763:-',
    #    'LeftBreakEntropy' => '1.7465'
    # }
    


    # =============================================================
    # This module should examine the contents of the 'annots' field
    #   and decide whether or not to filter the prediction.
    # =============================================================


    
    ## return(0) if the prediction is acceptable.

    ## return("reason for rejection")  if to be rejected.
    
    
    return(0);  # boilerplate just accepts everything.
}


1; #EOM
