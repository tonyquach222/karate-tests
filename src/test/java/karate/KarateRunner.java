package karate;

import com.intuit.karate.junit5.Karate;

class KarateRunner {

    @Karate.Test
    Karate testAll() {
        return Karate.run("classpath:karate/invoices.feature").relativeTo(getClass());
    }

}
