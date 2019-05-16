package com.fabiuslela.api.fabiusapi;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.fabiuslela.api.fabiusapi.filters.GlobalFilter;
import com.fabiuslela.api.fabiusapi.filters.SampleFilter;

@Configuration
public class FilterConfig {
    // @Autowired
    // private AutowireCapableBeanFactory beanFactory;

    // uncomment this and comment the @Component in the filter class definition to register only for a url pattern
    @Bean
    public FilterRegistrationBean<SampleFilter> sampleFilter() {
        FilterRegistrationBean<SampleFilter> registrationBean = new FilterRegistrationBean<>();
        // beanFactory.autowireBean(registrationBean);
        registrationBean.setFilter(new SampleFilter());
        registrationBean.setName("udm/getFuncFilter");
        registrationBean.addUrlPatterns("/udm/getFunc", "/path2");

        return registrationBean;
    }

    @Bean
    public FilterRegistrationBean<GlobalFilter> globalFilter() {
        FilterRegistrationBean<GlobalFilter> registrationBean = new FilterRegistrationBean<>();
        // beanFactory.autowireBean(registrationBean);
        registrationBean.setName("myGlobal");
        registrationBean.setFilter(new GlobalFilter());

        // registrationBean.addUrlPatterns("/udm/getFunc");

        return registrationBean;
    }
}
