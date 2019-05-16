package com.fabiuslela.api.fabiusapi;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.fabiuslela.api.fabiusapi.filters.SampleFilter;

@Configuration
public class FilterConfig {

    // uncomment this and comment the @Component in the filter class definition to register only for a url pattern
    @Bean
    public FilterRegistrationBean<SampleFilter> loggingFilter() {
        FilterRegistrationBean<SampleFilter> registrationBean = new FilterRegistrationBean<>();

        registrationBean.setFilter(new SampleFilter());

        registrationBean.addUrlPatterns("/udm/getFunc");

        return registrationBean;

    }

}
