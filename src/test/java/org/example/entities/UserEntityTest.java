package org.example.entities;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class UserEntityTest {

    @Test
    public void testUserEntityFields() {
        User user = new User();
        user.setName("Ali");
        user.setEmail("ali@example.com");

        assertEquals("Ali", user.getName());
        assertEquals("ali@example.com", user.getEmail());
    }
}
