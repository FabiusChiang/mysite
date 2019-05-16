package com.fabiuslela.api.fabiusapi.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

/**
 * A filter to create transaction before and commit it once request completes
 * The current implemenatation is just for demo
 * @author hemant
 *
 */
// @Component
@WebFilter
@Order(2)
public class GlobalFilter implements Filter {

	private final static Logger LOG = LoggerFactory.getLogger(SampleFilter.class);

	@Override
	public void init(final FilterConfig filterConfig) throws ServletException {
		LOG.info("Initializing filter :{}", this);
	}

	@Override
	public void doFilter(final ServletRequest request, final ServletResponse response, final FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
        LOG.info("GlobalFilter:{}", req.getRequestURI());
		chain.doFilter(request, response);
		LOG.info("GlobalFilter:{}", req.getRequestURI());
	}

	@Override
	public void destroy() {
		LOG.warn("Destructing filter :{}", this);
	}
}
