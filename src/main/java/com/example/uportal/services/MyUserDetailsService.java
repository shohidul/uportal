package com.example.uportal.services;

import com.example.uportal.models.MyUserDetails;
import com.example.uportal.models.MyUser;
import com.example.uportal.repositories.MyUserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.Optional;

@Service
public class MyUserDetailsService implements UserDetailsService {

    @Autowired
    MyUserRepository myUserRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Optional<MyUser> user = myUserRepository.findByEmail(email);
        System.out.println("mmm "+user.toString());
        user.orElseThrow(() -> new UsernameNotFoundException("Not found: " + email));

        return user.map(MyUserDetails::new).get();
    }
}
