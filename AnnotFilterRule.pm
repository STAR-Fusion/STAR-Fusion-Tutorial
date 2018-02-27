package AnnotFilterRule;

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


    my @filter_reasons;

    # see https://github.com/FusionAnnotator/CTAT_HumanFusionLib/wiki  for annotation attributes
    
    my $fusion_annot = $fusion_result_row->{'annots'};
    if ($fusion_annot) {
        
        my @removal_flags = qw(GTEx BodyMap DGD_PARALOGS HGNC_GENEFAM Greger_Normal Babiceanu_Normal ConjoinG);
        my @removal_flags_found;

        foreach my $removal_flag (@removal_flags) {
        
            if ($fusion_annot =~ /$removal_flag/) {
                push (@removal_flags_found, $removal_flag);
            }
        }

        if (@removal_flags_found) {
            push (@filter_reasons, "possible red herring as found in: " . join(",", @removal_flags_found));
        }
    }

    if ($fusion_result_row->{'LeftBreakpoint'} =~ /chrM:/i 
        ||
        $fusion_result_row->{'RightBreakpoint'} =~ /chrM:/i) {

        push (@filter_reasons, "involves a mitochondrial gene");
    }

    my $fusion_name = $fusion_result_row->{'#FusionName'};

    if ($fusion_name =~ /HLA/) {
        push (@filter_reasons, "involves HLA gene");
    }
        
    my ($geneA, $geneB) = split(/--/, $fusion_name);

    if ($geneA =~ /^IG[HKVL]/ && $geneB =~ /^IG[HKVL]/) {
        push (@filter_reasons, "immunoglobulin gene rearrangement");
    }
    
    ## return(0) if the prediction is acceptable.

    ## return("reason for rejection")  if to be rejected.

    if (@filter_reasons) {
        return(join("; ", @filter_reasons));
    }
    else {
        return(0); # all clear
    }
    
}


1; #EOM
