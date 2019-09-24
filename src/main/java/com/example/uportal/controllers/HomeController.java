package com.example.uportal.controllers;

import com.example.uportal.models.MyUserDetails;
import com.example.uportal.models.Role;
import com.example.uportal.models.MyUser;
import com.example.uportal.repositories.MyUserRepository;
import com.example.uportal.repositories.MyRoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class HomeController {

    @Autowired
    MyUserRepository myUserRepository;
    @Autowired
    MyRoleRepository myRoleRepository;
    @Autowired
    PasswordEncoder passwordEncoder;

    @RequestMapping(value="/login")
    public String login() {
        return ("login");
    }

    @RequestMapping(value="/registration")
    public String registration() {
        return ("registration");
    }

    @InitBinder
    public void initBinder(WebDataBinder binder){
        binder.registerCustomEditor(       Date.class,
                new CustomDateEditor(new SimpleDateFormat("dd/MM/yyyy"), true, 10));
    }

    @RequestMapping(value = "/registeruser", method = RequestMethod.POST)
    public String registeruser(@ModelAttribute("userFormData") @Valid MyUser formData, BindingResult
            bindingResult, ModelMap model) throws ParseException {

        if (bindingResult.hasErrors()) {
            final String errorMessage = "error! "+bindingResult;
            System.out.println(errorMessage);
            model.addAttribute("errorMessage ", errorMessage);
            return "/registration";
        }

        SimpleDateFormat dt1 = new SimpleDateFormat("YYYY-MM-DD", Locale.ENGLISH);
        Date date = dt1.parse(dt1.format(formData.getBirthDate()));

        formData.setBirthDate(date);

        Set<Role> roles = new HashSet<>();
        Role userRole = myRoleRepository.findByRole("USER");
        roles.add(userRole);

        formData.setPassword(passwordEncoder.encode(formData.getPassword()));
        formData.setRoles(roles);
        myUserRepository.save(formData);
        return "/greetings";
    }

    @RequestMapping(value = "/checkemail", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody
    boolean checkemail(@RequestParam("email") String email){
        if (myUserRepository.existsByEmail(email)) {
            return true;
        }else {
            return false;
        }
    }

    @RequestMapping(value = "/updatepassword", method = RequestMethod.POST)
    public @ResponseBody
    boolean  updatepassword(@RequestParam("password") String password, @RequestParam("newPassword") String newPassword){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        MyUserDetails userDetails = (MyUserDetails)auth.getPrincipal();

        boolean passMatched = passwordEncoder.matches(password, userDetails.getPassword());

        if (passMatched){
            MyUser user = userDetails.getUser();
            user.setPassword(passwordEncoder.encode(newPassword));
            myUserRepository.save(user);
        }
        else{
            return false;
        }
        return true;
    }

    @GetMapping("/profile")
    @PreAuthorize("hasAnyAuthority('USER')")
    public String profile(ModelMap model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        MyUserDetails userDetails = (MyUserDetails)auth.getPrincipal();
        model.addAttribute("user", userDetails.getUser());
        System.out.println(userDetails.getAuthorities()+" auth ");
        return ("profile");
    }
    @GetMapping("/change-password")
    @PreAuthorize("hasAnyAuthority('USER')")
    public String changePassword(ModelMap model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        MyUserDetails userDetails = (MyUserDetails)auth.getPrincipal();
        model.addAttribute("user", userDetails.getUser());
        return ("change-password");
    }
    @GetMapping("/admin")
    @PreAuthorize("hasAnyAuthority('ADMIN')")
    public String admin(ModelMap model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        MyUserDetails userDetails = (MyUserDetails)auth.getPrincipal();

        List<MyUser> users = myUserRepository.findAll();

        model.addAttribute("user", userDetails.getUser());
        model.addAttribute("users", users);
        return ("admin");
    }

}
