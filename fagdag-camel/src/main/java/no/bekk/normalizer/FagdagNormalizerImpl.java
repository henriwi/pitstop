package no.bekk.normalizer;

import no.bekk.domain.FagdagLog;
import org.springframework.stereotype.Service;

@Service("normalizer")
public class FagdagNormalizerImpl implements FagdagNormalizer {
    public FagdagLog fromTxtToLog(String line) {
        String[] fields = line.split(";");
        FagdagLog log = new FagdagLog();
        log.setCode(Long.valueOf(fields[1]));
        log.setMessage(fields[2 ]);
        return log;
    }
}
