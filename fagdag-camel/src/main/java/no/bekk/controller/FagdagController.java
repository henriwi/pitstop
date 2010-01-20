package no.bekk.controller;
//Her er en commit test!!
//Her er en ny commit med shortcuts
//commit 2
import no.bekk.domain.FagdagLog;
import no.bekk.repo.FagdagRepo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class FagdagController {
    @Resource
    private FagdagRepo fagdagRepo;

    @RequestMapping("/logs")
    public String doPage() {
        return "logs";
    }

    @ModelAttribute("logs")
    public List<FagdagLog> logs() {
        return fagdagRepo.list();
    }
}