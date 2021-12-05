package pontosecurity.restful.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.HttpHeaders;

import io.jsonwebtoken.Jwts;

public class RestAuthenticationFilter implements Filter {
	public static final String AUTHENTICATION_HEADER = "Authorization";

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filter)
			throws IOException, ServletException {

		if (request instanceof HttpServletRequest) {
			var httpServletRequest = (HttpServletRequest) request;
			var authorizationHeader = httpServletRequest.getHeader(HttpHeaders.AUTHORIZATION);

			try {
				var token = authorizationHeader.substring("Bearer".length()).trim();
				Jwts.parserBuilder().build().parseClaimsJws(token);
				filter.doFilter(request, response);
			} catch (Exception e) {
				if (response instanceof HttpServletResponse) {
					HttpServletResponse httpServletResponse = (HttpServletResponse) response;
					httpServletResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
				}
			}
		}
	}

	@Override
	public void destroy() {
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
	}

}
