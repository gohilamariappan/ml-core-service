FROM node:18

# Create a non-root user
RUN useradd -m appuser

# Create application directory & set permissions
WORKDIR /opt/core
RUN chown -R appuser:appuser /opt/core

# Switch to non-root user
USER appuser

# Copy package.json first (better caching)
COPY --chown=appuser:appuser package.json /opt/core/

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY --chown=appuser:appuser . /opt/core/

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]
