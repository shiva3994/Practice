def plot_lines(A_system):
    # Setup the x values for plotting
    x_vals = np.linspace(-10, 10, 100)
    
    # Extract coefficients for row 1: a1*x1 + b1*x2 = c1 -> x2 = (c1 - a1*x1) / b1
    row1 = A_system[0]
    x2_line1 = (row1[2] - row1[0] * x_vals) / row1[1]
    
    # Extract coefficients for row 2: a2*x1 + b2*x2 = c2 -> x2 = (c2 - a2*x1) / b2
    row2 = A_system[1]
    x2_line2 = (row2[2] - row2[0] * x_vals) / row2[1]
    
    # Plotting
    plt.figure(figsize=(6, 6))
    plt.plot(x_vals, x2_line1, label="Equation 1", color="blue")
    plt.plot(x_vals, x2_line2, label="Equation 2", color="orange")
    plt.axhline(0, color='black', linewidth=0.5)
    plt.axvline(0, color='black', linewidth=0.5)
    plt.grid(True, linestyle='--')
    plt.legend()
    plt.show()