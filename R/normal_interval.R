normal_interval <- function(prob, normal_pars,
                            Color = "orange"){
  normal_pars <- unlist(normal_pars)
  x_lo <- normal_pars[1] - 4 * normal_pars[2]
  x_hi <- normal_pars[1] + 4 * normal_pars[2]
  x <- seq(x_lo, x_hi, length.out=100)
  dx <- dnorm(x, normal_pars[1], normal_pars[2])
  p <- ggplot(data.frame(x=x, dx=dx), aes(x, dx)) +
    geom_line()
  interval <- qnorm(c((1 - prob) / 2, 1 - (1 - prob) / 2),
                    normal_pars[1], normal_pars[2])
#  interval <- round(interval, 1)
#  normal_pars <- round(normal_pars, 1)
  lo <- interval[1]
  hi <- interval[2]
  LO <- max(x_lo, lo)
  HI <- min(x_hi, hi)
  x0 <- seq(LO, HI, length.out=100)
  y0 <- dnorm(x0, normal_pars[1], normal_pars[2])
  xx <- c(LO, x0, HI, lo)
  yy <- c(0, y0, 0, 0)
  normprob <- diff(pnorm(c(lo, hi),
                  normal_pars[1], normal_pars[2]))
  message <- paste("P(",
                   round(lo, 3), "< M < ", round(hi, 3), ") =",
                   round(normprob, 3))
  other_text <- paste("Normal(",normal_pars[1], ", ",
                      normal_pars[2], ")", sep="")

  x_text <- normal_pars[1] - 2.5 * normal_pars[2]
  y_text <- .80 * max(dx)
  TH <- theme(
    plot.title = element_text(
      colour = "blue",
      size = 18,
      hjust = 0.5,
      vjust = 0.8,
      angle = 0
    )
  )
  p + geom_polygon(data=data.frame(xx, yy), aes(xx, yy),
                   fill=Color)  +
    ggtitle(message) +
    xlab("M") + ylab("Density") + TH +
    annotate("text", x = x_text, y = y_text,
             label = other_text,
             size=6, color="blue")
}
