module.exports = (plugin) => {
  plugin.setOptions({ dev: false });

  plugin.registerFunction(
    'SetLines',
    () => {
      return plugin.nvim
        .setLine('May I offer you an egg in these troubling times')
        .then(() => console.log('Line should be set'));
    },
    { sync: false }
  );
};
