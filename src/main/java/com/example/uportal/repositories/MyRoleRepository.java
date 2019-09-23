package com.example.uportal.repositories;

import com.example.uportal.models.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository("roleRepository")
public interface MyRoleRepository extends JpaRepository<Role, Integer> {
    Role findByRole(String role);

}