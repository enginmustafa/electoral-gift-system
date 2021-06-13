export function getProperDateFormat(fullDate) {
    const d = new Date(fullDate);
    const shortDateFormat = d.getDate() + "-" + (d.getMonth() + 1) + "-" + d.getFullYear();

    return shortDateFormat;
  }