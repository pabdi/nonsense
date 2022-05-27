package exam;

import java.util.Arrays;
import java.util.TreeSet;

public class StandardizeComp {

    public static void main(String[] args) {
        TreeSet<String> sortedRmDup = new TreeSet<>();
        Arrays.asList(companyNames).forEach(s -> {
            Arrays.asList(COMPANY).forEach(s1 -> {
                if (s1.contains(s1))
                    sortedRmDup.add(s1);
            });
        });

        sortedRmDup.forEach(s -> System.out.println(s));
    }

    private static String[] COMPANY = {"Genentech, Inc.",
            "Roche",
            "Google, Inc.",
            "Apple Inc.",
            "AstraZeneca"};
    private static String[] companyNames = {"Genentech, Inc",
            "Genentech 1000",
            "Genentech USA",
            "Genentech Roche Group",
            "Genentech USA 1010 **** Old entry title ****",
            "Roche 1112 Basel",
            "Roche",
            "Roche DIA",
            "Roche DIA Indianapolis",
            "Roche Santa Clara",
            "Google Inc.",
            "Google Alphabet",
            "Apple Inc.",
            "Apple Computer *** Old company ***",
            "Ship to AstraZeneca"};
}
