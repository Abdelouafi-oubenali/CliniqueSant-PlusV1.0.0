package org.example.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entities.Doctor;
import org.example.entities.Specialty;
import org.example.entities.Availability;
import org.example.repositories.DoctorRepository;
import org.example.repositories.SpecialtyRepository;
import org.example.repositories.AvailabilityRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import static org.mockito.Mockito.*;

class AppointmentServletTest {

    private AppointmentServlet servlet;
    private DoctorRepository doctorRepository;
    private SpecialtyRepository specialtyRepository;
    private AvailabilityRepository availabilityRepository;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private RequestDispatcher dispatcher;

    @BeforeEach
    void setUp() {
        servlet = new AppointmentServlet();

        // Mock des repositories
        doctorRepository = mock(DoctorRepository.class);
        specialtyRepository = mock(SpecialtyRepository.class);
        availabilityRepository = mock(AvailabilityRepository.class);

        servlet.setDoctorRepository(doctorRepository);
        servlet.setSpecialtyRepository(specialtyRepository);
        servlet.setAvailabilityRepository(availabilityRepository);

        // Mock des objets HTTP
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        dispatcher = mock(RequestDispatcher.class);

        when(request.getRequestDispatcher(anyString())).thenReturn(dispatcher);
    }

    @Test
    void testDoGet() throws Exception {
        // Préparer les données simulées
        Doctor doctor = new Doctor();
        doctor.setId(1L);
        doctor.setTitle("Dr");
        when(doctorRepository.findAll()).thenReturn(List.of(doctor));

        Specialty specialty = new Specialty();
        specialty.setId(1L);
        specialty.setName("Cardiology");
        when(specialtyRepository.findAll()).thenReturn(List.of(specialty));

        Availability availability = new Availability();
        when(availabilityRepository.findCurrentByDoctor(1L))
                .thenReturn(List.of(availability));

        // Appeler la méthode doGet
        servlet.doGet(request, response);

        // Vérifier que les attributs ont été définis
        verify(request).setAttribute(eq("doctors"), anyList());
        verify(request).setAttribute(eq("specialties"), anyList());
        verify(request).setAttribute(eq("doctorAvailabilities"), anyMap());
        verify(request).setAttribute(eq("today"), eq(LocalDate.now()));

        verify(dispatcher).forward(request, response);
    }
}
