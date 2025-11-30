# Create Business Site

One-command business website generation from requirements to live deployment.

## Usage
```
/create-business-site "Business requirements description"
```

## Examples
```bash
# Restaurant with online reservations
/create-business-site "Italian restaurant with table reservations, menu display, staff scheduling, and customer reviews"

# Service business  
/create-business-site "Marketing agency with client portal, project management, invoice tracking, and service packages"

# Retail store
/create-business-site "Boutique clothing store with product catalog, inventory management, customer accounts, and order processing"
```

## What This Command Does

Executes the complete 0→1 workflow to deliver a functional business website:

1. **Requirements Planning** → Analyze and confirm understanding with user
2. **Parse Requirements** → Extract business type and feature requirements  
3. **Initialize Project** → Create directory structure and Astro setup
4. **Setup Database** → Create Supabase project with business schema
5. **Generate Components** → Build UI components for business needs
6. **Configure Deployment** → Setup Cloudflare Pages with environment
7. **Deploy Live Site** → Push to production at pages.dev domain

## Command Execution Flow

### Phase 1: Requirements Planning (MANDATORY)
**ALWAYS start with this planning phase before any implementation:**

1. **Parse Requirements**: Analyze the business description to extract:
   - Business type and industry
   - Core features and functionality needed
   - Target audience and use cases
   - Technical requirements and constraints

2. **Present Understanding**: Display a clear summary in this format:
   ```
   ## Business Website Plan
   
   **Business Type**: [Restaurant/Retail/Service/Events/Other]
   **Industry**: [Specific industry vertical]
   **Project Name**: [generated-project-name]
   
   **Core Features**:
   - Feature 1: [Description and purpose]
   - Feature 2: [Description and purpose]  
   - Feature 3: [Description and purpose]
   
   **Database Schema**:
   - Table 1: [Purpose and key fields]
   - Table 2: [Purpose and key fields]
   
   **User Roles**:
   - [Role 1]: [Permissions and access]
   - [Role 2]: [Permissions and access]
   
   **Out of Scope** (for initial version):
   - [Feature/complexity not included]
   - [Advanced features for later phases]
   ```

3. **Request Clarification**: Ask specific questions about any ambiguous requirements:
   - "Do you need payment processing or just service display?"
   - "Should staff be able to manage their own schedules?"
   - "Do you need customer reviews/ratings functionality?"
   - "What user roles do you need (admin, manager, staff)?"

4. **Confirm Implementation Plan**: Present the step-by-step approach:
   ```
   ## Implementation Steps
   1. Initialize [project-name] with Astro + React + Supabase
   2. Create [X] database tables with row-level security
   3. Generate [Y] UI components for core features
   4. Implement authentication with [Z] user roles
   5. Deploy to https://[project-name].pages.dev
   
   Estimated completion: [timeframe]
   ```

5. **Wait for Approval**: **DO NOT PROCEED** until user confirms:
   - "This understanding is correct"
   - "Please proceed with implementation"
   - "I want to modify [specific aspect]"

### Phase 2: Implementation (Only After Approval)
Once requirements are confirmed, proceed with the technical implementation following the workflow below.

## Implementation Workflow

### Step 1: Project Initialization
Based on the approved plan, begin implementation:
```bash
# Execute initialization script
cd /home/user/code/for-clients/business-site-generator
./scripts/init-project.sh [project-name]

# This creates:
# /home/user/code/for-clients/[project-name]/
# ├── astro-site/          # Astro application
# ├── memory-bank/         # Claude documentation  
# └── .claude/commands/    # Project automation
```

### Step 2: Memory Bank Population
**IMPORTANT**: After project initialization, immediately populate memory-bank files with actual business information from the approved requirements plan. 

Replace template placeholders in these files:
- **projectbrief.md**: Business name, industry, features, goals
- **systemPatterns.md**: Database schema, component architecture  
- **activeContext.md**: Current project status and next steps
- **progress.md**: Implementation roadmap and success criteria

Do NOT leave template placeholders like {BUSINESS_NAME} - use the actual parsed business requirements to create functional documentation.

### Step 3: Database Setup
```bash
# Execute Supabase setup command
cd [project-name]
claude-code /setup-supabase

# This will:
# - Create Supabase project using MCP server
# - Generate business-specific schema
# - Configure authentication and RLS
# - Set environment variables
```

### Step 4: Component Generation
```bash
# Generate business-specific UI components
claude-code /generate-components [business-type] [features]

# Creates components like:
# - Authentication (login, signup, profile)
# - Business features (booking, catalog, dashboard)
# - Layout components (header, sidebar, footer)
```

### Step 5: Deployment Preparation
```bash
# Verify production readiness
claude-code /deploy-check

# This validates:
# - Code quality and type safety
# - Security and performance
# - Environment configuration
# - Build process
```

### Step 6: Live Deployment
```bash
# Deploy to Cloudflare Pages
./scripts/deploy-site.sh [project-name]

# Results in:
# - Live site at https://[project-name].pages.dev
# - SSL certificate automatically configured
# - Environment variables set for production
```

## Business Type Templates

### Restaurant/Food Service
**Core Features Generated**:
- Menu display with categories and pricing
- Table reservation system with availability
- Staff scheduling and shift management
- Customer review and rating system
- Online ordering and delivery tracking

**Database Schema**:
- `menus`, `menu_items`, `reservations`, `tables`, `staff_schedules`

### Retail/E-commerce
**Core Features Generated**:
- Product catalog with search and filtering
- Shopping cart and checkout flow
- Inventory management dashboard
- Customer account management
- Order tracking and fulfillment

**Database Schema**:
- `products`, `categories`, `orders`, `cart_items`, `inventory`

### Service Business
**Core Features Generated**:
- Service package display and pricing
- Appointment booking and scheduling
- Client management dashboard
- Project tracking and invoicing
- Staff and resource allocation

**Database Schema**:
- `services`, `appointments`, `clients`, `projects`, `invoices`

### Events/Entertainment
**Core Features Generated**:
- Event calendar and listing
- Ticket sales and capacity management
- Venue management and booking
- Attendee check-in and management
- Event promotion and marketing tools

**Database Schema**:
- `events`, `venues`, `tickets`, `attendees`, `event_categories`

## Customization Options

### Styling Themes
- **Modern Minimalist**: Clean lines, lots of white space
- **Corporate Professional**: Conservative colors, structured layout  
- **Creative/Artistic**: Bold colors, dynamic layouts
- **Industry-Specific**: Restaurant warmth, retail polish, etc.

### Feature Modules
- **Authentication**: Basic, social login, multi-factor
- **Payments**: Stripe integration, invoice generation
- **Communications**: Email notifications, SMS alerts
- **Analytics**: Basic tracking, advanced reporting

## Quality Assurance

### Automated Testing
- Component unit tests for business logic
- API integration tests for data operations
- End-to-end tests for user workflows
- Performance tests for Core Web Vitals

### Manual Verification
- Cross-browser compatibility testing
- Mobile responsiveness validation
- Accessibility compliance (WCAG AA)
- Business workflow verification

## Success Criteria

**Technical Requirements**:
- ✅ Site loads at pages.dev domain in < 3 seconds
- ✅ All core business features functional
- ✅ Authentication and security properly configured
- ✅ Mobile responsive design working correctly
- ✅ Performance scores > 90 on Lighthouse

**Business Requirements**:
- ✅ Core business workflows can be completed
- ✅ User registration and account management works
- ✅ Business-specific features match requirements
- ✅ Admin dashboard provides necessary controls
- ✅ Site ready for custom domain configuration

## Troubleshooting

### Common Issues
- **Supabase Project Creation Fails**: Check organization billing setup
- **Build Errors**: Verify all dependencies installed correctly
- **Deployment Fails**: Check Cloudflare Pages configuration
- **Database Connection Issues**: Verify environment variables

### Recovery Actions
- **Start Over**: Delete project directory and re-run command
- **Partial Recovery**: Run individual commands (setup-supabase, etc.)
- **Manual Fix**: Edit specific files and re-run deploy-check

## Output and Next Steps

### Immediate Deliverables
- **Live Website**: Functional site at https://[project-name].pages.dev
- **Source Code**: Complete codebase ready for customization
- **Documentation**: Memory bank with development context
- **Admin Access**: Credentials for site administration

### Client Handoff Process
1. **Demo Session**: Walk through all features with client
2. **Training**: Teach content management and basic administration
3. **Documentation**: Provide user guides and technical documentation
4. **Support Plan**: Establish ongoing maintenance and support arrangement

### Future Enhancement Path
- Custom domain configuration and SSL setup
- Advanced feature development based on usage
- Performance optimization and scaling
- Integration with third-party services
- Custom branding and design refinements

This command transforms a single sentence business description into a complete, functional website ready for production use.