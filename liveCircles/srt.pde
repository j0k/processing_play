

// AML fix: logic translation for lang2lang and from struct2struct can be made with ML, DS & natural language processing
// AML principles: logic-structure translations

import java.util.Comparator; 

public class CustomComparator implements Comparator<LCircle> {
    @Override
    public int compare(LCircle lc1, LCircle lc2) {
        return (lc1.r > lc2.r)?1:0;
    }
}